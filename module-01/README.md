# Module 1: Understanding Zero Trust Security

> **Course:** [Mastering SPIFFE & SPIRE](https://coderssecret.com/courses/mastering-spiffe-spire)
> **Full Content:** [Module 1 on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire/understanding-zero-trust-security)

## Learning Objectives

- Understand why traditional perimeter security fails in cloud-native systems
- Learn the core principles of Zero Trust architecture
- Differentiate between human identity and workload identity
- Understand service-to-service authentication challenges

## Labs

### Lab 1: Exploring Traditional vs Zero Trust Architectures

**Path:** [`lab/lab-01-traditional-vs-zerotrust/`](./lab/lab-01-traditional-vs-zerotrust)

Compare network-based security with identity-based security by observing service communication patterns.

```bash
cd lab/lab-01-traditional-vs-zerotrust
./setup.sh
```

### Lab 2: Inspecting Service Communication Flows

**Path:** [`lab/lab-02-traffic-inspection/`](./lab/lab-02-traffic-inspection)

Capture and inspect unencrypted service-to-service traffic to understand the attack surface.

```bash
cd lab/lab-02-traffic-inspection
./setup.sh
```

## Key Takeaways

- Network location is not identity — IPs change, containers are ephemeral
- Zero trust requires cryptographic verification on every request
- Workload identity is the machine equivalent of human SSO
- SPIFFE/SPIRE provides the standards-based foundation for zero trust
- This course takes you from Level 0 (no identity) to Level 4 (full zero trust)

## Next Module

[Module 2: Cryptography and PKI Foundations →](../module-02)
