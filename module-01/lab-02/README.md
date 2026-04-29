# Lab 2 — Inspecting Service Communication Flows

## Objective

Capture and inspect unencrypted service-to-service traffic to understand the attack surface.

## Steps

1. Deploy a simple microservice application (frontend + API + database)
2. Use tcpdump to capture traffic between pods
3. Observe unencrypted HTTP traffic with visible headers and payloads
4. Document the security gaps: no encryption, no identity, no authorization

## Setup

```bash
kubectl apply -f microservices.yaml

# Capture traffic between frontend and API
kubectl run tcpdump --image=corfr/tcpdump --rm -it -- -i any -A 'host api'
```
