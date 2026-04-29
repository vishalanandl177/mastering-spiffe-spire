# Module 3: SPIFFE Fundamentals

> **Course:** [Mastering SPIFFE & SPIRE](https://coderssecret.com/courses/mastering-spiffe-spire)
> **Full Content:** [Module 3 on coderssecret.com](https://coderssecret.com/courses/mastering-spiffe-spire/spiffe-fundamentals)

## Learning Objectives

- Understand the SPIFFE specification and its components
- Learn SPIFFE ID format and trust domains
- Master X.509-SVIDs and JWT-SVIDs
- Use the SPIFFE Workload API

## Labs

### Lab 1: Designing SPIFFE ID Schemas
[`lab/lab-01-spiffe-ids/`](./lab/lab-01-spiffe-ids) — Map a microservice app to SPIFFE IDs.

### Lab 2: Inspecting SVID Formats
[`lab/lab-02-svid-formats/`](./lab/lab-02-svid-formats) — Compare X.509-SVID and JWT-SVID structures.

## Key Takeaways

- SPIFFE is a specification, not an implementation — SPIRE is the implementation
- Trust domains are the root of trust, identified by a domain name
- SPIFFE IDs are URIs: `spiffe://trust-domain/path`
- X.509-SVIDs are for mTLS, JWT-SVIDs are for HTTP APIs

## Next Module

[Module 4: SPIRE Architecture and Components →](../module-04)
