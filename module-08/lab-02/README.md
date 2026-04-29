# Lab 2 — SPIRE + OPA Authorization End-to-End

Combines SPIRE-issued certs with OPA policy enforcement via Envoy ext_authz.

See module-07/lab-02 for the OPA + Envoy pieces. This lab adds SPIRE for the identity layer.

```bash
docker compose up -d
# Service-A (with SPIFFE ID orders-api) can call Service-B
# Service-A cannot call /admin/* — OPA denies based on SPIFFE ID
```
