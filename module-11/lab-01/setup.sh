#!/bin/bash
set -e
# Run Vault in dev mode
docker run -d --name vault -p 8200:8200 \
  --cap-add=IPC_LOCK \
  -e VAULT_DEV_ROOT_TOKEN_ID=root \
  hashicorp/vault:latest

export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root

sleep 3

# Enable JWT auth
vault auth enable jwt

# Get SPIRE Server's OIDC discovery URL
SPIRE_OIDC_URL="http://spire-oidc.example.org"

# Configure Vault to trust SPIRE's JWTs
vault write auth/jwt/config \
  oidc_discovery_url="$SPIRE_OIDC_URL" \
  bound_issuer="$SPIRE_OIDC_URL"

# Create a role tied to a SPIFFE ID
vault write auth/jwt/role/spire-role \
  role_type=jwt \
  user_claim=sub \
  bound_subject=spiffe://example.org/ns/default/sa/api \
  policies=default,read-secrets \
  ttl=1h

echo "✓ Vault configured to accept SPIFFE JWTs"
