# Module 2: Cryptography and PKI Foundations

> **Course:** [Mastering SPIFFE & SPIRE](https://coderssecret.com/courses/mastering-spiffe-spire)
> **Full Content:** [Module 2 on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire/cryptography-pki-foundations)

## Learning Objectives

- Understand symmetric vs asymmetric encryption
- Learn how PKI and certificate authorities work
- Master X.509 certificates and certificate chains
- Implement mutual TLS between services

## Labs

### Lab 1: Creating a Root Certificate Authority
[`lab/lab-01-root-ca/`](./lab/lab-01-root-ca) — Build PKI hierarchy with OpenSSL.

### Lab 2: Generating and Signing Certificates
[`lab/lab-02-cert-signing/`](./lab/lab-02-cert-signing) — Issue end-entity certs with SPIFFE ID in SAN.

### Lab 3: Establishing mTLS Between Services
[`lab/lab-03-mtls/`](./lab/lab-03-mtls) — Mutual TLS server and client.

## Key Takeaways

- Asymmetric encryption solves the key distribution problem
- PKI provides a scalable trust hierarchy for certificate management
- X.509 certificates bind a public key to an identity
- mTLS authenticates BOTH client and server — the foundation of zero trust
- Short-lived certificates limit blast radius but require automatic rotation

## Next Module

[Module 3: SPIFFE Fundamentals →](../module-03)
