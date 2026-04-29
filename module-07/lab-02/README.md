# Lab 2 — Integrating OPA with Envoy

## Run

```bash
docker compose up -d

# Should succeed (orders-api SPIFFE ID can read /api/orders)
curl -H "x-spiffe-id: spiffe://example.org/ns/default/sa/orders-api" \
  http://localhost:8000/api/orders

# Should be 403 (orders-api cannot delete users)
curl -X DELETE -H "x-spiffe-id: spiffe://example.org/ns/default/sa/orders-api" \
  http://localhost:8000/api/users/1
```
