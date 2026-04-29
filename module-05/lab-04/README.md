# Lab 4 — Debugging Failed Attestation

Intentionally misconfigure a workload selector and observe the failure.

```bash
# Register with WRONG service account
kubectl exec -n spire spire-server-0 -- /opt/spire/bin/spire-server entry create \
  -spiffeID spiffe://example.org/ns/default/sa/wrong \
  -parentID spiffe://example.org/ns/spire/sa/spire-agent \
  -selector k8s:ns:default \
  -selector k8s:sa:wrong-name

# Deploy a pod that does not match
kubectl apply -f mismatched-pod.yaml

# Watch agent logs
kubectl logs -n spire daemonset/spire-agent | grep -i "attest\|denied"
```

The agent will log: `no entries matched selectors`. Fix by updating the selector or the SA name.
