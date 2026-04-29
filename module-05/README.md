# Module 5: Running SPIRE on Kubernetes

> **Course:** [Mastering SPIFFE & SPIRE](https://coderssecret.com/courses/mastering-spiffe-spire)
> **Full Content:** [Module 5 on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire/running-spire-on-kubernetes)

## Learning Objectives

- Deploy SPIRE Server and Agent on Kubernetes
- Configure Kubernetes workload and node attestors
- Use SPIRE Controller Manager for automatic registration
- Retrieve SVIDs inside pods

## Labs

### Lab 1: Deploy SPIRE on Kind
[`lab/lab-01-spire-on-kind/`](./lab/lab-01-spire-on-kind) — Full SPIRE stack on a local cluster.

### Lab 2: Auto-Register Workloads
[`lab/lab-02-auto-register/`](./lab/lab-02-auto-register) — Use Controller Manager and ClusterSPIFFEID.

### Lab 3: Identity Rotation
[`lab/lab-03-rotation/`](./lab/lab-03-rotation) — Watch SVIDs rotate without app restart.

### Lab 4: Debugging Failed Attestation
[`lab/lab-04-debugging/`](./lab/lab-04-debugging) — Common errors and fixes.

## Key Takeaways

- SPIRE Server runs as a StatefulSet, Agent as a DaemonSet
- SPIRE Controller Manager auto-registers workloads from K8s metadata
- CSI Driver mounts the Workload API socket into pods transparently
- SVIDs rotate automatically — applications never handle certificate renewal

## Next Module

[Module 6: Working with SVIDs and the Workload API →](../module-06)
