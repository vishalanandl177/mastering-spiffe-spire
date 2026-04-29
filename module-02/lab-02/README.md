# Lab 2 — Generating and Signing Certificates

## Objective

Issue end-entity certificates for services, with SPIFFE IDs in the SAN URI field.

## Run

```bash
# Run after lab-01 (depends on the CA from that lab)
cp -r ../lab-01/ca .
./issue-svid.sh service-a
./issue-svid.sh service-b
./inspect.sh service-a
```
