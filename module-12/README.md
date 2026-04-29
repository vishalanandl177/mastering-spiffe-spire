# Module 12 — Capstone: Building a Complete Zero Trust Platform

> [Course page](https://coderssecret.com/courses/mastering-spiffe-spire/building-zero-trust-platform)

This is the capstone project. You will deploy a complete zero trust stack across two clusters:

- SPIRE Server (HA) on both clusters
- SPIRE Agents (DaemonSet) on every node
- Envoy sidecars for mTLS
- OPA for authorization
- Federation between the two clusters
- Prometheus + Grafana for monitoring

## Lab

- [capstone: End-to-End Zero Trust Platform](./capstone)
