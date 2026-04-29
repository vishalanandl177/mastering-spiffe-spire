# Lab 3 — OIDC Discovery with SPIRE

Configure SPIRE Server as an OIDC provider and verify JWT-SVIDs externally.

```bash
# Enable OIDC discovery on SPIRE Server (already enabled in spire-server.yaml below)
kubectl apply -f spire-server-oidc.yaml

# Fetch the discovery document
curl https://oidc-discovery.example.org/.well-known/openid-configuration

# Get a JWT-SVID for a workload
spire-agent api fetch jwt -audience https://api.example.com
```
