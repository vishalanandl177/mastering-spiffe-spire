# Mastering SPIFFE & SPIRE: Zero Trust for Cloud Native Systems

> **Free, Production-Focused Course on Workload Identity**
>
> Companion repository for the [Mastering SPIFFE & SPIRE course](https://coderssecret.com/courses/mastering-spiffe-spire) on [coderssecret.com](https://coderssecret.com).

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Course Website](https://img.shields.io/badge/Course-coderssecret.com-blue)](https://coderssecret.com/courses/mastering-spiffe-spire)
[![CNCF SPIFFE](https://img.shields.io/badge/CNCF-SPIFFE-purple)](https://spiffe.io)

---

## Why This Course Exists

Workload identity is the foundation of modern cloud-native security. Yet most engineers learn SPIFFE/SPIRE through scattered docs, outdated blog posts, or expensive training. **This course is 100% free and production-focused.**

By the end, you will:

- Deploy SPIRE on Kubernetes from scratch
- Configure mTLS between microservices using SPIFFE identities
- Enforce authorization policies with OPA + SPIRE
- Federate identity across multiple clusters
- Operate SPIRE in production with monitoring and runbooks

This is **not just a SPIFFE course**. It is a way to learn modern cloud-native identity security and become more valuable in the AI/cloud-native era.

## Course Modules

| # | Module | Lab Path |
|---|--------|----------|
| 1 | [Understanding Zero Trust Security](./module-01) | `module-01/` |
| 2 | [Cryptography and PKI Foundations](./module-02) | `module-02/` |
| 3 | [SPIFFE Fundamentals](./module-03) | `module-03/` |
| 4 | [SPIRE Architecture and Components](./module-04) | `module-04/` |
| 5 | [Running SPIRE on Kubernetes](./module-05) | `module-05/` |
| 6 | [Working with SVIDs and Workload API](./module-06) | `module-06/` |
| 7 | [Authorization and Policy Enforcement](./module-07) | `module-07/` |
| 8 | [SPIRE Integrations and Service Mesh](./module-08) | `module-08/` |
| 9 | [Advanced SPIRE Architectures](./module-09) | `module-09/` |
| 10 | [Day Two Operations and Observability](./module-10) | `module-10/` |
| 11 | [The SPIFFE/SPIRE Ecosystem](./module-11) | `module-11/` |
| 12 | [Building a Complete Zero Trust Platform (Capstone)](./module-12) | `module-12/` |
| 13 | [SPIFFE for AI Infrastructure (Bonus)](./module-13) | `module-13/` |

## Prerequisites

- Basic understanding of Linux command line
- Familiarity with Docker and Kubernetes
- A laptop with at least 8GB RAM
- Comfort with reading YAML and shell scripts

## Lab Environment Setup

```bash
# Required tools:
# - Docker Desktop or Podman
# - kubectl 1.28+
# - kind 0.20+ (for local Kubernetes clusters)
# - openssl
# - curl, jq

# Verify installations:
docker --version
kubectl version --client
kind --version
openssl version
```

See [docs/setup.md](./docs/setup.md) for detailed installation instructions.

## How to Use This Repository

1. **Read the course content** at [coderssecret.com/courses/mastering-spiffe-spire](https://coderssecret.com/courses/mastering-spiffe-spire)
2. **Clone this repo** for the lab files
3. **Follow each module** in order — they build on each other
4. **Run the labs** in your local environment
5. **Star this repo** if you find it useful!

```bash
git clone https://github.com/vishalanandl177/mastering-spiffe-spire.git
cd mastering-spiffe-spire
cd module-01/lab && ./setup.sh
```

## Learning Roadmap

```
Foundations (Modules 1-3)
    ↓
SPIRE Implementation (Modules 4-6)
    ↓
Authorization & Integration (Modules 7-8)
    ↓
Production Architecture (Modules 9-10)
    ↓
Ecosystem & Capstone (Modules 11-12)
    ↓
Future: AI Infrastructure (Module 13)
```

## Architecture Diagrams

All architecture diagrams are in the [`diagrams/`](./diagrams) folder as SVG files. Each module also has its own diagrams in `module-XX/diagrams/`.

## About the Instructor

**Vishal Anand** — Senior Product Engineer & Tech Lead

- Creator of [DRF API Logger](https://github.com/vishalanandl177/DRF-API-Logger) — open-source Django package used across enterprise systems
- Author of 80+ engineering tutorials at [coderssecret.com](https://coderssecret.com)
- 1-on-1 consultation available at [coderssecret.com/consultation](https://coderssecret.com/consultation)

[GitHub](https://github.com/vishalanandl177) · [LinkedIn](https://linkedin.com/in/vishal-techlead) · [Website](https://coderssecret.com)

## Contributing

Contributions welcome! Open an issue or PR if you find bugs, have improvements, or want to add additional lab scenarios.

## License

MIT License — see [LICENSE](./LICENSE)

## Resources

- [SPIFFE Official Site](https://spiffe.io)
- [SPIRE Documentation](https://spiffe.io/docs/latest/spire-about/)
- [CNCF SPIFFE Page](https://www.cncf.io/projects/spiffe/)
- [Course on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire)

---

⭐ **If this course helps you, please star this repo!** It helps others discover the content.
