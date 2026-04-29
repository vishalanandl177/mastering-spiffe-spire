#!/bin/bash
set -e
# Get bundle from cluster-a's SPIRE Server
kubectl --context kind-cluster-a -n spire exec spire-server-0 -- \
  /opt/spire/bin/spire-server bundle show -format pem > cluster-a-bundle.pem

# Get bundle from cluster-b's SPIRE Server
kubectl --context kind-cluster-b -n spire exec spire-server-0 -- \
  /opt/spire/bin/spire-server bundle show -format pem > cluster-b-bundle.pem

# Set bundles in opposite clusters
kubectl --context kind-cluster-a -n spire exec spire-server-0 -- \
  /opt/spire/bin/spire-server bundle set \
  -id spiffe://cluster-b.example.org \
  -path /tmp/cluster-b-bundle.pem

kubectl --context kind-cluster-b -n spire exec spire-server-0 -- \
  /opt/spire/bin/spire-server bundle set \
  -id spiffe://cluster-a.example.org \
  -path /tmp/cluster-a-bundle.pem

echo "✓ Federation configured"
