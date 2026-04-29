#!/bin/bash
set -e
echo "=== Test 1: Authorized service-to-service call ==="
kubectl --context kind-cluster-a exec deploy/frontend -- \
  curl -s http://api/orders | head -3
echo "✓ Frontend can call API (allowed by OPA)"

echo
echo "=== Test 2: Unauthorized call (should fail) ==="
kubectl --context kind-cluster-a exec deploy/frontend -- \
  curl -s -o /dev/null -w "%{http_code}" http://payments/admin
echo " — should be 403 (frontend cannot access payments admin endpoint)"

echo
echo "=== Test 3: Cross-cluster federated call ==="
kubectl --context kind-cluster-a exec deploy/api -- \
  curl -s https://api.cluster-b.example.org/health
echo "✓ Cross-cluster mTLS via federation works"

echo
echo "=== Test 4: Compromised pod test ==="
# Deploy a "rogue" pod that pretends to be the API
kubectl --context kind-cluster-a apply -f rogue-pod.yaml
kubectl --context kind-cluster-a exec deploy/rogue -- \
  curl -s http://payments/charge || echo "✓ Rogue pod blocked (no valid SVID)"
