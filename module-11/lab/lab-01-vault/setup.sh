#!/bin/bash
# Configure Vault to accept SPIFFE JWT-SVIDs
set -e

# 1. Enable JWT auth method
vault auth enable jwt

# 2. Configure Vault to trust SPIRE's OIDC discovery
vault write auth/jwt/config \
    oidc_discovery_url="https://spire-server.example.org:8443" \
    bound_issuer="spiffe://example.org"

# 3. Create a Vault role that maps SPIFFE IDs to Vault policies
vault write auth/jwt/role/spire-workload \
    role_type="jwt" \
    user_claim="sub" \
    bound_audiences="vault" \
    bound_subject="spiffe://example.org/ns/default/sa/payment-service" \
    policies="payment-secrets" \
    ttl="1h"

# 4. Workload authenticates with JWT-SVID
spire-agent api fetch jwt -audience vault \
    -socketPath /run/spire/sockets/agent.sock \
    -spiffeID spiffe://example.org/ns/default/sa/payment-service > jwt.token

vault write auth/jwt/login \
    role=spire-workload \
    jwt=@jwt.token

# Result: workload gets a Vault token without ever managing static credentials
echo "Workload authenticated to Vault via SPIFFE!"
