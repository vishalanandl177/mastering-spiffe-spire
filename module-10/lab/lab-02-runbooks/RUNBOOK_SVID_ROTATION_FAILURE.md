# Runbook: SVID Rotation Failure

## Symptom

Alert: `SvidRotationStalled`

Workload identities are not being renewed. If not addressed within TTL, all mTLS connections will fail.

## Severity: CRITICAL

If SVIDs expire, every service-to-service connection breaks.

## Quick Triage (5 minutes)

```bash
# 1. Check if SPIRE Server is healthy
kubectl -n spire get pods -l app=spire-server

# 2. Check Agent connectivity
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server agent list

# 3. Check Agent logs for errors
kubectl -n spire logs ds/spire-agent --tail=100 | grep -E "ERROR|FATAL"
```

## Common Root Causes

### 1. Server Database Issues

```bash
# Check server logs for DB errors
kubectl -n spire logs spire-server-0 | grep -i "datastore\|postgres\|sql"

# If using Postgres, check connectivity
kubectl -n spire exec spire-server-0 -- nc -zv postgres.spire.svc 5432
```

### 2. Network Partition

```bash
# Test agent → server connectivity from each node
kubectl -n spire exec ds/spire-agent -- nc -zv spire-server 8081
```

### 3. Trust Bundle Expired

```bash
# Check CA expiration
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server bundle show \
  | openssl x509 -noout -dates
```

## Resolution Steps

### Quick Fix: Restart Agents

```bash
# Force agents to re-attest and refresh state
kubectl -n spire rollout restart daemonset/spire-agent
```

### If Server is Unhealthy

```bash
# Restart server (will reuse data from Postgres)
kubectl -n spire rollout restart statefulset/spire-server
```

### If CA is Expiring Soon

```bash
# Trigger CA rotation
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server x509 mint \
  -spiffeID spiffe://example.org/test \
  -ttl 3600s
```

## Post-Incident

1. Investigate root cause from logs
2. Update monitoring thresholds if needed
3. Document any new failure modes
4. Schedule regular CA rotation drills
