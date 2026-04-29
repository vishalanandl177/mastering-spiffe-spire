#!/bin/bash
set -e

# Register the demo workload
kubectl exec -n spire spire-server-0 -- /opt/spire/bin/spire-server entry create \
  -spiffeID spiffe://example.org/ns/default/sa/demo \
  -parentID spiffe://example.org/ns/spire/sa/spire-agent \
  -selector k8s:ns:default \
  -selector k8s:sa:demo

# Deploy the demo workload
kubectl apply -f demo-workload.yaml
kubectl wait --for=condition=ready pod -l app=demo --timeout=60s
echo "✓ Workload registered and deployed"
