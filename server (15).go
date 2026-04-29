# Module 4: SPIRE Architecture and Components

> **Course:** [Mastering SPIFFE & SPIRE](https://coderssecret.com/courses/mastering-spiffe-spire)
> **Full Content:** [Module 4 on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire/spire-architecture-components)

## Learning Objectives

- Understand SPIRE Server and Agent architecture
- Learn node attestation and workload attestation
- Configure registration entries
- Master the SPIRE plugin framework

## Labs

### Lab 1: Installing SPIRE from Binaries
[`lab/lab-01-install-spire/`](./lab/lab-01-install-spire) — Run SPIRE locally without Kubernetes.

### Lab 2: Configuring Registration Entries
[`lab/lab-02-registration/`](./lab/lab-02-registration) — Register workloads and assign SPIFFE IDs.

### Lab 3: Attesting Nodes and Workloads
[`lab/lab-03-attestation/`](./lab/lab-03-attestation) — Observe the full attestation flow.

## Key Takeaways

- SPIRE Server is the control plane — manages registrations and signs SVIDs
- SPIRE Agent runs on every node — exposes the Workload API to local workloads
- Node attestation proves the Agent is on a legitimate node
- Workload attestation proves the calling process matches a registration entry

## Next Module

[Module 5: Running SPIRE on Kubernetes →](../module-05)
