#!/bin/bash
# Capstone Step 7: Validate the zero trust platform
set -e

echo "=== Zero Trust Platform Validation ==="
echo ""

kubectl config use-context kind-production

# Test 1: Authorized service can call backend
echo "[Test 1] frontend → api (should succeed)"
kubectl -n ecommerce exec deploy/frontend -- \
  curl -sf https://api/orders && echo "✓ PASS" || echo "✗ FAIL"

# Test 2: Unauthorized service cannot call payments
echo ""
echo "[Test 2] frontend → payments (should fail — OPA denies)"
kubectl -n ecommerce exec deploy/frontend -- \
  curl -sf https://payments/charge && echo "✗ FAIL (should have been denied!)" || echo "✓ PASS (denied as expected)"

# Test 3: Compromised pod (random pod in namespace) cannot impersonate
echo ""
echo "[Test 3] random pod → api (should fail — no SPIFFE ID)"
kubectl -n ecommerce run attacker --image=curlimages/curl --rm -it --restart=Never -- \
  curl -sf https://api/orders && echo "✗ FAIL (should have been denied!)" || echo "✓ PASS (denied — no valid SVID)"

# Test 4: Cross-cluster federation
echo ""
echo "[Test 4] staging api → production api (should succeed via federation)"
kubectl config use-context kind-staging
kubectl -n ecommerce exec deploy/api -- \
  curl -sf https://api.production.example.org/health && echo "✓ PASS" || echo "✗ FAIL"

# Test 5: SVID rotation (background)
echo ""
echo "[Test 5] SVID rotation in progress..."
kubectl -n ecommerce exec deploy/api -- \
  /opt/spire/bin/spire-agent api fetch x509 \
  -socketPath /run/spire/sockets/agent.sock \
  | grep "Expires" \
  && echo "✓ Active SVID present"

echo ""
echo "=== Zero Trust Platform Validated ==="
