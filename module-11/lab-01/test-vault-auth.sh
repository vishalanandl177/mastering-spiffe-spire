#!/bin/bash
set -e

# Get a JWT-SVID for the workload
JWT=$(spire-agent api fetch jwt -audience http://localhost:8200 -spiffeID spiffe://example.org/ns/default/sa/api | head -1 | awk '{print $2}')

# Authenticate to Vault using the JWT
TOKEN=$(curl -s --request POST \
  --data "{\"jwt\": \"$JWT\", \"role\": \"spire-role\"}" \
  http://localhost:8200/v1/auth/jwt/login | jq -r .auth.client_token)

echo "✓ Got Vault token: ${TOKEN:0:20}..."

# Use the Vault token to read a secret
curl -s -H "X-Vault-Token: $TOKEN" \
  http://localhost:8200/v1/secret/data/myapp
