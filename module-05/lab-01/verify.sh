#!/bin/bash
kubectl get pods -n spire
echo
echo "=== SPIRE Server logs ==="
kubectl logs -n spire statefulset/spire-server --tail=20
