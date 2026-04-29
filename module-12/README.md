# Module 12: Building a Complete Zero Trust Platform (Capstone)

> **Course:** [Mastering SPIFFE & SPIRE](https://coderssecret.com/courses/mastering-spiffe-spire)
> **Full Content:** [Module 12 on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire/building-zero-trust-platform)

## The Capstone Project

Combine everything from the previous 11 modules into a complete, production-style zero trust platform.

## Architecture

- **Two Kubernetes clusters** (production and staging)
- **HA SPIRE deployment** on both clusters
- **Microservice e-commerce app** with Envoy sidecars
- **OPA policies** for service-to-service authorization
- **SPIFFE federation** between clusters
- **Prometheus monitoring** with SPIRE-specific dashboards

## Steps

```bash
cd capstone
./00-setup-clusters.sh         # Create both Kind clusters
./01-deploy-spire.sh            # Deploy HA SPIRE to both
./02-deploy-app.sh              # Deploy e-commerce microservices
./03-configure-envoy.sh         # Add Envoy sidecars with SPIRE SDS
./04-deploy-opa.sh              # Add OPA + Rego policies
./05-setup-federation.sh        # Federate cluster A and B
./06-deploy-monitoring.sh       # Prometheus + Grafana
./07-test-zero-trust.sh         # Run security tests
```

## What You Validate

1. ✓ Every service has a unique SPIFFE ID
2. ✓ All inter-service traffic is mTLS-encrypted
3. ✓ OPA policies block unauthorized service calls
4. ✓ Compromised service cannot impersonate others
5. ✓ Cross-cluster mTLS works via federation
6. ✓ SVID rotation happens transparently
7. ✓ Monitoring catches attestation failures

## Reference Architecture

See [diagrams/zero-trust-platform.svg](./diagrams/zero-trust-platform.svg) for the complete architecture diagram.

This is your template for production deployments.
