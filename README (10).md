#!/bin/bash
# Lab 2: Generate end-entity certificate with SPIFFE ID in SAN
set -e

echo "=== Lab 2: Issuing Certificates with SPIFFE ID ==="
echo ""

# Use Intermediate CA from Lab 1
INTERMEDIATE_CERT="../lab-01-root-ca/ca/intermediate/certs/intermediate.cert.pem"
INTERMEDIATE_KEY="../lab-01-root-ca/ca/intermediate/private/intermediate.key.pem"

if [ ! -f "$INTERMEDIATE_CERT" ]; then
  echo "ERROR: Run Lab 1 first to create the Intermediate CA"
  exit 1
fi

mkdir -p svids

# Generate service private key
echo "[1/3] Generating service private key..."
openssl genrsa -out svids/service-a.key.pem 2048

# Create CSR config with SPIFFE ID in SAN
cat > svids/service-a.cnf <<EOF
[req]
distinguished_name = req_dn
req_extensions = v3_req
prompt = no

[req_dn]
CN = service-a

[v3_req]
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
URI.1 = spiffe://example.org/ns/default/sa/service-a
DNS.1 = service-a
EOF

# Create CSR
echo "[2/3] Creating CSR with SPIFFE ID in SAN..."
openssl req -new \
  -key svids/service-a.key.pem \
  -out svids/service-a.csr.pem \
  -config svids/service-a.cnf

# Sign with Intermediate CA
echo "[3/3] Signing certificate with Intermediate CA..."
openssl x509 -req \
  -in svids/service-a.csr.pem \
  -CA "$INTERMEDIATE_CERT" \
  -CAkey "$INTERMEDIATE_KEY" \
  -CAcreateserial \
  -out svids/service-a.cert.pem \
  -days 1 \
  -sha256 \
  -extfile svids/service-a.cnf \
  -extensions v3_req

echo ""
echo "=== X.509-SVID Created ==="
echo ""
echo "Inspect the SVID:"
openssl x509 -in svids/service-a.cert.pem -noout -text | grep -A 1 "Subject Alternative Name"

echo ""
echo "Notice the URI SAN: this is a SPIFFE ID!"
echo "  spiffe://example.org/ns/default/sa/service-a"
echo ""
echo "TTL: 1 day (production typically uses 1 hour)"
