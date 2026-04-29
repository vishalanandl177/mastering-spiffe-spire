# Runbook: Node Attestation Failures

## Symptoms

- Agent logs: `failed to attest: rpc error: code = PermissionDenied`
- New nodes cannot join the SPIRE deployment

## Investigation

```bash
kubectl logs -n spire daemonset/spire-agent --tail=50 | grep -i attest

# For k8s_psat attestor, verify the service account token
kubectl exec -n spire daemonset/spire-agent -- \
  cat /var/run/secrets/kubernetes.io/serviceaccount/token | head -c 100

# Check server-side attestor config
kubectl get configmap -n spire spire-server -o yaml
```

## Common Causes

| Cause | Fix |
|-------|-----|
| Wrong cluster name in agent config | Match `cluster` in agent.conf to server's cluster list |
| Service account not allow-listed | Add to `service_account_allow_list` in server config |
| Token review API blocked | Check RBAC permissions on `tokenreviews` resource |
| Clock skew | Sync NTP on all nodes |
