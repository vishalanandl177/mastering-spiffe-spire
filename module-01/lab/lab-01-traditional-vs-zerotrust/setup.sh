#!/bin/bash
# Lab 1: Traditional vs Zero Trust Architecture
# Deploys two services to compare network-based vs identity-based security

set -e

echo "=== Lab 1: Traditional vs Zero Trust ==="
echo ""

# Create kind cluster
echo "Creating Kind cluster..."
kind create cluster --name zerotrust-lab --config cluster.yaml || echo "Cluster may already exist"

# Wait for cluster
kubectl wait --for=condition=Ready nodes --all --timeout=60s

# Deploy traditional security (no identity)
echo ""
echo "Deploying traditional architecture (no identity verification)..."
kubectl apply -f traditional/

# Wait for pods
kubectl wait --for=condition=ready pod -l app=service-a --timeout=60s
kubectl wait --for=condition=ready pod -l app=service-b --timeout=60s

# Demonstrate the problem
echo ""
echo "=== TEST 1: Service A calls Service B (should work) ==="
kubectl exec deploy/service-a -- curl -s http://service-b/data

echo ""
echo "=== TEST 2: Compromised pod (in same namespace) calls Service B ==="
echo "    Without identity, ANY pod can call ANY other pod!"
kubectl run attacker --image=curlimages/curl --rm -it --restart=Never -- curl -s http://service-b/data

echo ""
echo "=== Lab 1 Complete ==="
echo ""
echo "Observations:"
echo "  1. Service B has NO way to verify WHO is calling it"
echo "  2. Network policies could restrict by namespace, but not service identity"
echo "  3. If attacker compromises ANY pod in namespace, they can impersonate Service A"
echo ""
echo "Next: Lab 2 - Traffic Inspection"
echo "  cd ../lab-02-traffic-inspection && ./setup.sh"
