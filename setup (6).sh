#!/bin/bash
# Lab 2: Inspect unencrypted service-to-service traffic
set -e

echo "=== Lab 2: Traffic Inspection ==="
echo ""
echo "This lab demonstrates that without mTLS, traffic between services"
echo "is visible in cleartext to anyone who can capture network packets."
echo ""

# Reuse cluster from Lab 1 if exists
kubectl cluster-info >/dev/null 2>&1 || kind create cluster --name zerotrust-lab

kubectl apply -f sample-app.yaml
kubectl wait --for=condition=ready pod -l app=frontend --timeout=60s
kubectl wait --for=condition=ready pod -l app=api --timeout=60s

echo ""
echo "Capturing traffic between frontend and API (10 seconds)..."
echo "Notice: HTTP headers, body, and credentials are all visible!"
echo ""

# Capture traffic on the API pod
API_POD=$(kubectl get pod -l app=api -o jsonpath='{.items[0].metadata.name}')

# Generate some traffic in the background
kubectl exec deploy/frontend -- sh -c 'for i in 1 2 3; do curl -s -H "Authorization: Bearer secret-token-12345" http://api/users; sleep 1; done' &

# Capture
kubectl exec $API_POD -- timeout 5 sh -c 'apk add --no-cache tcpdump 2>/dev/null; tcpdump -i eth0 -A -s 0 port 8080 2>/dev/null' || true

echo ""
echo "=== Observations ==="
echo "  1. Bearer token visible in cleartext"
echo "  2. Request and response payloads visible"
echo "  3. No way for API to verify the calling service identity"
echo ""
echo "This is what zero trust + mTLS solves. Continue to Module 2."
