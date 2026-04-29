# Common SPIRE Debugging Scenarios

## Error 1: "no identity issued" when fetching SVID

**Symptom:**
```
spire-agent api fetch x509
ERROR: workload received no identity
```

**Root Causes:**
1. No registration entry matches the workload's selectors
2. Workload is in a namespace excluded by ClusterSPIFFEID
3. Service account name doesn't match the SPIFFE ID template

**Debug:**
```bash
# Check what registration entries exist
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server entry show

# Check which selectors should match this pod
kubectl get pod my-pod -o jsonpath='{.metadata.namespace}/{.spec.serviceAccountName}'

# Check Controller Manager logs
kubectl -n spire logs deploy/spire-controller-manager
```

## Error 2: "agent fails to connect to server"

**Symptom (in agent logs):**
```
ERROR: failed to attest: rpc error: code = Unauthenticated
```

**Root Causes:**
1. ServiceAccount mismatch (k8s_psat NodeAttestor)
2. Trust domain mismatch between agent and server
3. Server not reachable from agent node

**Debug:**
```bash
# Verify agent service account
kubectl -n spire get sa spire-agent

# Test connectivity from agent to server
kubectl -n spire exec daemonset/spire-agent -- nc -zv spire-server 8081

# Check agent and server trust_domain match in configs
```

## Error 3: "trust bundle update failed"

**Symptom:**
Agent can't validate server cert, repeated reconnection attempts.

**Fix:**
```bash
# Force refresh the bundle
kubectl -n spire exec spire-server-0 -- \
  /opt/spire/bin/spire-server bundle show > bundle.crt

# Mount it into agents (or restart so init container fetches fresh)
kubectl -n spire rollout restart daemonset/spire-agent
```

## Error 4: Pod can't access socket

**Symptom:**
```
ERROR: dial unix /run/spire/sockets/agent.sock: connect: no such file or directory
```

**Root Causes:**
1. Agent not running on the same node as the pod
2. HostPath mount missing or wrong path
3. SecurityContext blocking access

**Fix:**
```bash
# Verify socket exists on the host
kubectl -n spire exec ds/spire-agent -- ls -la /run/spire/sockets

# Check pod has the volume mount
kubectl describe pod my-pod | grep -A 5 Mounts
```

## Error 5: SVID expires before rotation

**Symptom:**
Workload connections fail intermittently with TLS errors.

**Root Cause:**
Rotation interval too long for TTL.

**Fix:**
- Reduce TTL in ClusterSPIFFEID (e.g., from 24h to 1h)
- Or rebuild Workload API client with shorter check interval
- For SPIFFE Helper, set `renew_signal` and `cmd_args` correctly

## Useful Commands

```bash
# Server status
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server agent list
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server entry show

# Agent socket on host (any node)
kubectl -n spire exec ds/spire-agent -- ls -la /run/spire/sockets

# Live SVID
kubectl exec my-pod -- /opt/spire/bin/spire-agent api fetch x509 \
  -socketPath /run/spire/sockets/agent.sock

# Server health
kubectl -n spire exec spire-server-0 -- /opt/spire/bin/spire-server healthcheck
```
