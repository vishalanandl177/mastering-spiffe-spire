# Lab 1 — Writing Basic Rego Policies

## Run

```bash
opa test . -v
opa eval -d authz.rego -i input-allow.json "data.authz.allow"
opa eval -d authz.rego -i input-deny.json "data.authz.allow"
```
