# Mastering SPIFFE & SPIRE: Zero Trust for Cloud Native Systems

> The companion repository for the free course at [coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire)

This repository contains all hands-on labs, Kubernetes manifests, configuration files, and reference architectures for the **Mastering SPIFFE & SPIRE** course — a complete free curriculum on zero-trust workload identity.

## What You Will Learn

- How perimeter security fails in cloud-native systems
- Cryptographic foundations (PKI, X.509, mTLS, JWT)
- The SPIFFE specification — trust domains, SVIDs, Workload API
- SPIRE architecture — Server, Agent, attestation, registration
- Production deployment on Kubernetes with auto-rotation
- Service mesh integration (Envoy, Istio, Linkerd)
- Authorization with Open Policy Agent (OPA)
- Multi-cluster federation and high availability
- Day-two operations, observability, and troubleshooting
- Real-world integrations (Vault, Cilium, CI/CD)
- Securing AI infrastructure with workload identity

## Course Modules

| # | Module | Labs |
|---|--------|------|
| 1 | [Understanding Zero Trust Security](./module-01) | 2 |
| 2 | [Cryptography and PKI Foundations](./module-02) | 3 |
| 3 | [SPIFFE Fundamentals](./module-03) | 2 |
| 4 | [SPIRE Architecture and Components](./module-04) | 3 |
| 5 | [Running SPIRE on Kubernetes](./module-05) | 4 |
| 6 | [Working with SVIDs and the Workload API](./module-06) | 3 |
| 7 | [Authorization and Policy Enforcement](./module-07) | 2 |
| 8 | [SPIRE Integrations and Service Mesh](./module-08) | 3 |
| 9 | [Advanced SPIRE Architectures](./module-09) | 2 |
| 10 | [Day Two Operations and Observability](./module-10) | 2 |
| 11 | [The SPIFFE/SPIRE Ecosystem](./module-11) | 2 |
| 12 | [Capstone: Building a Zero Trust Platform](./module-12) | 1 |
| 13 | [Bonus: SPIFFE for AI Infrastructure](./module-13) | 1 |

## Prerequisites

- Linux/macOS environment with bash
- Docker installed
- kubectl installed
- [kind](https://kind.sigs.k8s.io/) for local Kubernetes
- [Go 1.21+](https://go.dev/) (some labs)
- OpenSSL (for PKI labs)

## Lab Repository Structure

```
mastering-spiffe-spire/
├── module-01/
│   ├── README.md
│   ├── lab-01/             # Exploring perimeter vs zero trust
│   └── lab-02/             # Inspecting service communication
├── module-02/
│   ├── README.md
│   ├── lab-01/             # Building a Root CA
│   ├── lab-02/             # Issuing certificates
│   └── lab-03/             # Establishing mTLS
├── ...
├── module-12/
│   └── capstone/           # End-to-end zero trust platform
└── module-13/
    └── lab-01/             # Securing AI agents
```

Each lab folder contains:
- `README.md` — Lab objectives and step-by-step instructions
- Setup/teardown scripts
- Configuration files (YAML, conf, Rego policies)
- Verification scripts where applicable

## How to Use This Repo

1. Read the corresponding module on the [course site](https://coderssecret.com/courses/mastering-spiffe-spire)
2. Clone this repo: `git clone https://github.com/vishalanandl177/mastering-spiffe-spire.git`
3. Navigate to the lab folder for the current module
4. Follow the README instructions
5. Run the setup scripts and verify results

## License

MIT — feel free to use these labs for your own learning, training, or workshops.

## About the Author

Created by **Vishal Anand**, Senior Product Engineer & Tech Lead.

- Creator of [DRF API Logger](https://github.com/vishalanandl177/DRF-API-Logger) — open-source Django package with 1.6M+ downloads, used across enterprise systems
- Educator at [coderssecret.com](https://coderssecret.com)
- LinkedIn: [vishal-techlead](https://linkedin.com/in/vishal-techlead)

## Contributing

Found a bug? Have an improvement? PRs welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Stars and Support

If this course helped you, please star this repo and share it with your team. Your support helps make more free, production-grade content possible.
