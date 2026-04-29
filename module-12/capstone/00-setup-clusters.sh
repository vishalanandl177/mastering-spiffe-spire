#!/bin/bash
set -e
echo "Creating two Kind clusters..."
for c in cluster-a cluster-b; do
  cat > /tmp/$c-config.yaml <<KIND
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
KIND
  kind create cluster --name $c --config /tmp/$c-config.yaml
done
echo "✓ Clusters created"
kubectl config get-contexts
