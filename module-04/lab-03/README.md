# Lab 3 — Attesting Nodes and Workloads

## Objective

Observe the full attestation flow with debug logging.

## Steps

1. Restart the SPIRE Server with `log_level = "DEBUG"` (already set in lab-01/server.conf)
2. Restart the SPIRE Agent with debug logs enabled
3. Trigger a workload SVID fetch
4. Read the logs to identify each phase: node attestation → workload attestation → SVID issuance

## Common attestation failures to test

```bash
# Try fetching as a different UID (will fail)
sudo -u nobody ../lab-01/spire/bin/spire-agent api fetch x509 \
  -socketPath /tmp/spire-agent/public/api.sock
# Expected: no SVID returned (no matching registration entry)
```
