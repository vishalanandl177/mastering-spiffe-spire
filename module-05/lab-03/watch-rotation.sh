#!/bin/bash
POD=$(kubectl get pod -l app=demo -o jsonpath='{.items[0].metadata.name}')
echo "Watching SVID expiration. Will rotate ~80% before TTL expiry."
while true; do
  kubectl exec "$POD" -- /opt/spire/bin/spire-agent api fetch x509 \
    -socketPath /run/spire/sockets/agent.sock 2>/dev/null | \
    grep -oP 'Not After: \S+ \S+ \S+ \S+'
  sleep 30
done
