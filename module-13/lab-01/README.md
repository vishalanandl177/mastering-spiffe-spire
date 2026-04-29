# Lab 1 — Securing AI Agent Communication

## Objective

Give AI agents SPIFFE identities and enforce policies on which agents can call which LLM endpoints.

## Run

```bash
./register-ai-workloads.sh
docker compose up
./test-policies.sh
```
