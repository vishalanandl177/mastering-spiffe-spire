#!/bin/bash
set -e
kubectl create namespace spire
kubectl apply -f spire-server.yaml
kubectl apply -f spire-agent.yaml
echo "Waiting for SPIRE to be ready..."
kubectl rollout status -n spire statefulset/spire-server --timeout=120s
kubectl rollout status -n spire daemonset/spire-agent --timeout=120s
echo "✓ SPIRE deployed"
