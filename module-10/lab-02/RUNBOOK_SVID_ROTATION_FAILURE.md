# Runbook: SVID Rotation Failure

## Symptoms

- Workload gets `connection refused` or `bad certificate` errors
- Logs show `failed to rotate SVID`
- `spire_agent_svid_rotations_total` is flat in Prometheus

## Investigation

```bash
# Check agent logs
kubectl logs -n spire daemonset/spire-agent --tail=100 | grep -i rotat

# Check server connectivity from agent
kubectl exec -n spire daemonset/spire-agent -- \
  /opt/spire/bin/spire-agent healthcheck

# Check registration entry still exists
kubectl exec -n spire spire-server-0 -- \
  /opt/spire/bin/spire-server entry show -spiffeID <SPIFFE_ID>
```

## Common Causes

| Cause | Fix |
|-------|-----|
| Server unreachable from agent | Check service `spire-server` and network policies |
| Registration entry deleted | Recreate with `entry create` |
| CA expired | Check `ca_ttl` config, rotate CA |
| Clock skew between nodes | Ensure NTP is running on all nodes |

## Escalation

If rotation does not recover within 1 hour, escalate to platform team. Workloads will fail when their current SVID expires.
