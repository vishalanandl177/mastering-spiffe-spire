# Lab 1 — Exploring Traditional vs Zero Trust Architectures

## Objective

Compare network-based security with identity-based security by observing service communication patterns.

## Steps

1. Deploy two services in a Kubernetes namespace without any security
2. Observe that any pod can call any other pod without authentication
3. Add NetworkPolicies and observe the limitations
4. Discuss what is missing: identity verification and encryption

## Setup

```bash
# Create a kind cluster
kind create cluster --name zero-trust-demo

# Deploy two demo services
kubectl apply -f services.yaml

# Try calling service-b from service-a (no auth required!)
kubectl exec -it deploy/service-a -- curl http://service-b.default.svc.cluster.local
```

## Files

- `services.yaml` — Two demo services without security
- `network-policy.yaml` — Adds basic network segmentation
- `verify.sh` — Verification script
