#!/bin/bash
set -e
# Register the current user as a workload
USER_ID=$(id -u)
../lab-01/spire/bin/spire-server entry create \
  -parentID spiffe://example.org/agent \
  -spiffeID spiffe://example.org/user/$USER \
  -selector "unix:uid:$USER_ID"

echo "✓ Registered workload for UID $USER_ID"
../lab-01/spire/bin/spire-server entry show
