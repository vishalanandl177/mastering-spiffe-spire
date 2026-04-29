# Lab 1 — Exploring SPIFFE IDs

## Objective

Understand SPIFFE ID format and design naming conventions for a microservice application.

## Exercise

Design SPIFFE IDs for these services:

1. A `payments` service in the `production` namespace, running on AWS us-east-1
2. A `data-pipeline` service running as a Kubernetes Job in `analytics` namespace
3. A CI/CD GitHub Actions workflow for the `frontend` repository
4. A VM-based legacy service called `legacy-billing` in `us-west` region

See `solution.md` for one possible naming schema.
