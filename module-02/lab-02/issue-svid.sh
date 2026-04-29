#!/bin/bash
set -e
SERVICE=$1
[ -z "$SERVICE" ] && echo "Usage: $0 <service-name>" && exit 1

cd ca

# Generate service private key
openssl genrsa -out "$SERVICE.key" 2048

# Create CSR with SPIFFE ID in SAN URI
cat > "$SERVICE.cnf" <<CNF
[req]
distinguished_name=req
req_extensions=v3_req
prompt=no
[req]
CN=$SERVICE.example.org
[v3_req]
subjectAltName=URI:spiffe://example.org/ns/default/sa/$SERVICE
CNF

openssl req -new -key "$SERVICE.key" \
  -config "$SERVICE.cnf" \
  -out "$SERVICE.csr"

# Sign with Intermediate CA
openssl x509 -req -in "$SERVICE.csr" \
  -CA int-ca.crt -CAkey int-ca.key -CAcreateserial \
  -days 1 -sha256 \
  -extfile "$SERVICE.cnf" -extensions v3_req \
  -out "$SERVICE.crt"

echo "✓ SVID issued for $SERVICE (1 day TTL — short-lived!)"
