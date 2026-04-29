#!/bin/bash
# Auto-register workloads with SPIRE Controller Manager
set -e

echo "=== Lab 2: Auto-Register Workloads ==="
echo ""

# Apply ClusterSPIFFEID resource
kubectl apply -f cluster-spiffe-id.yaml

# Deploy demo app
kubectl apply -f demo-app.yaml
kubectl wait --for=condition=ready pod -l app=demo-app --timeout=60s

# Verify SVID is issued
echo ""
echo "Fetching SVID from inside the demo pod..."
kubectl exec deploy/demo-app -- /opt/spire/bin/spire-agent api fetch x509 \
  -socketPath /run/spire/sockets/agent.sock

echo ""
echo "✓ Workload received SVID automatically!"
echo ""
echo "Notice the SPIFFE ID in the certificate:"
echo "  spiffe://example.org/ns/default/sa/demo-app"
