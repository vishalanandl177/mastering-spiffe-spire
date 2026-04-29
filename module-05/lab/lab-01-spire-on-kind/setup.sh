#!/bin/bash
# Deploy SPIRE on a local Kind cluster
set -e

echo "=== Lab 1: SPIRE on Kind ==="
echo ""

# Create cluster
kind create cluster --name spire-lab --config kind-config.yaml || echo "Cluster exists"

# Create namespace
kubectl create namespace spire || true

# Apply server (StatefulSet)
echo "[1/3] Deploying SPIRE Server..."
kubectl apply -f spire-server.yaml

# Wait for server
kubectl -n spire wait --for=condition=ready pod -l app=spire-server --timeout=120s

# Apply agent (DaemonSet)
echo "[2/3] Deploying SPIRE Agent..."
kubectl apply -f spire-agent.yaml

# Wait for agents
kubectl -n spire wait --for=condition=ready pod -l app=spire-agent --timeout=120s

# Verify
echo ""
echo "[3/3] Verifying deployment..."
kubectl -n spire get pods
echo ""
kubectl -n spire exec deploy/spire-server -- /opt/spire/bin/spire-server agent list

echo ""
echo "✓ SPIRE deployed successfully!"
echo ""
echo "Next: Auto-register workloads with Controller Manager (Lab 2)"
