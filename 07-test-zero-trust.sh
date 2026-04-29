#!/bin/bash
# Observe SVID rotation
set -e

echo "=== Lab 3: SVID Rotation ==="
echo ""
echo "Watching SVID expiration timestamps..."
echo "TTL is 1 hour, rotation begins at ~50% TTL (30 min before expiry)"
echo ""

while true; do
    SVID_OUT=$(kubectl exec deploy/demo-app -- /opt/spire/bin/spire-agent api fetch x509 \
      -socketPath /run/spire/sockets/agent.sock 2>&1 | grep -E "SPIFFE ID|Expires")

    echo "[$(date '+%Y-%m-%d %H:%M:%S')]"
    echo "$SVID_OUT"
    echo ""

    sleep 60
done
