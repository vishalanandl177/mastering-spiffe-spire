#!/bin/bash
# Capstone Step 0: Create production and staging Kind clusters
set -e

echo "=== Capstone Setup: Multi-Cluster Zero Trust Platform ==="
echo ""

cat > prod-cluster.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: production
nodes:
  - role: control-plane
  - role: worker
  - role: worker
EOF

cat > staging-cluster.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: staging
nodes:
  - role: control-plane
  - role: worker
EOF

kind create cluster --config prod-cluster.yaml
kind create cluster --config staging-cluster.yaml

# Switch context for production
kubectl config use-context kind-production
kubectl create namespace spire || true
kubectl create namespace ecommerce || true

# Switch context for staging
kubectl config use-context kind-staging
kubectl create namespace spire || true
kubectl create namespace ecommerce || true

echo ""
echo "✓ Both clusters ready"
echo "Next: ./01-deploy-spire.sh"
