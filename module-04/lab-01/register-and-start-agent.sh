#!/bin/bash
set -e
mkdir -p data/agent

# Generate trust bundle for the agent
./spire/bin/spire-server bundle show > data/agent/bundle.crt

# Generate a join token
TOKEN=$(./spire/bin/spire-server token generate -spiffeID spiffe://example.org/agent | awk '{print $2}')
echo "Got join token: $TOKEN"

# Start agent with the token
./spire/bin/spire-agent run -config agent.conf -joinToken "$TOKEN"
