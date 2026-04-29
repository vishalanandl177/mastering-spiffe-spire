#!/bin/bash
# Decode a JWT-SVID and show the SPIFFE ID in the sub claim
JWT=${1:-"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IktleS1JZCJ9.eyJzdWIiOiJzcGlmZmU6Ly9leGFtcGxlLm9yZy9ucy9kZWZhdWx0L3NhL2FwaS1zZXJ2ZXIiLCJhdWQiOlsic3BpZmZlOi8vZXhhbXBsZS5vcmcvbnMvZGVmYXVsdC9zYS9kYXRhYmFzZSJdLCJleHAiOjE3MTQyMzc2MDB9.signature"}

PAYLOAD=$(echo "$JWT" | cut -d'.' -f2)
# Add padding for base64 decode
PADDED=$(printf '%s%s' "$PAYLOAD" "$(printf '%*s' $(( 4 - ${#PAYLOAD} % 4 )) '' | tr ' ' '=')")
echo "=== JWT-SVID Payload ==="
echo "$PADDED" | base64 -d 2>/dev/null | jq . 2>/dev/null || echo "Install jq to format JSON"
