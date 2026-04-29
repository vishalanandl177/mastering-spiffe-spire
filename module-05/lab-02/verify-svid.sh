#!/bin/bash
POD=$(kubectl get pod -l app=demo -o jsonpath='{.items[0].metadata.name}')
kubectl exec "$POD" -- /opt/spire/bin/spire-agent api fetch x509 \
  -socketPath /run/spire/sockets/agent.sock
