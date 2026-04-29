#!/bin/bash
set -e
cat > kind-config.yaml <<KIND
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
  - role: worker
KIND
kind create cluster --name spire-demo --config kind-config.yaml
kubectl cluster-info
