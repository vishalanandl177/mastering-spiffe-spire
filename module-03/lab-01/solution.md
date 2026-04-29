# Reference SPIFFE ID Schema

```
# Kubernetes workloads:
spiffe://example.org/k8s/prod-cluster/ns/production/sa/payments
spiffe://example.org/k8s/analytics-cluster/ns/analytics/sa/data-pipeline

# CI/CD:
spiffe://example.org/cicd/github/myorg/frontend/main

# VM workloads:
spiffe://example.org/vm/us-west/legacy-billing

# General principles:
# - Hierarchical paths reflect organizational structure
# - Include cluster name for multi-cluster deployments
# - Use service account, not pod name (pods are ephemeral)
# - Document the schema for your organization
```
