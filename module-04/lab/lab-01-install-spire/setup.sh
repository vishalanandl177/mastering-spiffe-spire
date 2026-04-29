#!/bin/bash
# Install and run SPIRE Server + Agent locally
set -e

echo "=== Lab 1: Install SPIRE Locally ==="
echo ""

# Check SPIRE is installed
if ! command -v spire-server &> /dev/null; then
    echo "ERROR: spire-server not found. Install SPIRE first."
    echo "See ../../../docs/setup.md"
    exit 1
fi

mkdir -p data/server data/agent

# Bootstrap CA
echo "[1/4] Starting SPIRE Server..."
echo "Run in terminal 1:"
echo "  spire-server run -config server.conf"
echo ""
echo "Then in terminal 2 (this script will continue):"
echo "  spire-server bundle show -socketPath /tmp/spire-server/private/api.sock > data/agent/bundle.crt"
echo "  spire-server token generate -spiffeID spiffe://example.org/agent -socketPath /tmp/spire-server/private/api.sock"
echo ""
echo "Copy the join token, then start the agent:"
echo "  spire-agent run -config agent.conf -joinToken <TOKEN>"
echo ""
echo "Verify:"
echo "  spire-server agent list -socketPath /tmp/spire-server/private/api.sock"
