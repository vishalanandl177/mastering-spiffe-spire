#!/bin/bash
# Register workloads with SPIRE Server
set -e

SOCKET="/tmp/spire-server/private/api.sock"

echo "=== Lab 2: Registering Workloads ==="
echo ""

# Register a Unix workload
echo "Registering workload (running as current user)..."

UID_VAL=$(id -u)
GID_VAL=$(id -g)

spire-server entry create \
  -socketPath "$SOCKET" \
  -spiffeID "spiffe://example.org/workload/demo" \
  -parentID "spiffe://example.org/agent" \
  -selector "unix:uid:$UID_VAL" \
  -selector "unix:gid:$GID_VAL"

echo ""
echo "List entries:"
spire-server entry show -socketPath "$SOCKET"

echo ""
echo "Now fetch SVID as a workload:"
echo "  spire-agent api fetch x509 -socketPath /tmp/spire-agent/public/api.sock"
