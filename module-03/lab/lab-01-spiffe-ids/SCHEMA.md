# SPIFFE ID Schema Design

This lab is a design exercise. Map a microservice e-commerce application to SPIFFE IDs.

## Application

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   Frontend   │───>│      API     │───>│   Database   │
└──────────────┘    └──────┬───────┘    └──────────────┘
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
        ┌─────────┐  ┌─────────┐  ┌──────────┐
        │  Orders │  │ Payments│  │ Inventory│
        └─────────┘  └─────────┘  └──────────┘
```

## Environments

- **Production:** cluster `prod-us-east`
- **Staging:** cluster `staging`
- **Development:** cluster `dev`

## Schema Design

```
spiffe://example.org/<environment>/<service>

Examples:
spiffe://example.org/prod-us-east/frontend
spiffe://example.org/prod-us-east/api
spiffe://example.org/prod-us-east/orders
spiffe://example.org/prod-us-east/payments
spiffe://example.org/prod-us-east/inventory
spiffe://example.org/prod-us-east/database

spiffe://example.org/staging/frontend
spiffe://example.org/staging/api
...

spiffe://example.org/dev/frontend
...
```

## Alternative: Kubernetes-Native Schema

```
spiffe://example.org/k8s/<cluster>/ns/<namespace>/sa/<service-account>

Examples:
spiffe://example.org/k8s/prod-us-east/ns/default/sa/frontend
spiffe://example.org/k8s/prod-us-east/ns/default/sa/api-server
spiffe://example.org/k8s/prod-us-east/ns/payments/sa/payment-processor
```

## Best Practices

1. **Include environment** in the path so policies can target environments
2. **Use service account, not pod name** — pods are ephemeral, service accounts are stable
3. **Keep paths hierarchical** for wildcard policy matching
4. **Document the schema** for your organization
5. **Validate uniqueness** — no two workloads should share an ID

## Exercise

Design a SPIFFE ID schema for your own organization. Consider:
- Multi-cloud deployments
- Multiple Kubernetes clusters
- VM and bare-metal workloads
- CI/CD pipelines
- Third-party services

Write your schema in `your-schema.md` and validate the SPIFFE IDs against the spec at https://github.com/spiffe/spiffe/blob/main/standards/SPIFFE-ID.md
