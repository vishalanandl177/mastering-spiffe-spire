#!/bin/bash
# Lab 1: Build a complete PKI hierarchy from scratch
set -e

echo "=== Lab 1: Creating a Root CA ==="
echo ""

mkdir -p ca/{root,intermediate}/{certs,private,csr}
cd ca

# Step 1: Generate Root CA private key
echo "[1/5] Generating Root CA private key..."
openssl genrsa -out root/private/ca.key.pem 4096

# Step 2: Self-sign Root CA certificate
echo "[2/5] Creating self-signed Root CA certificate..."
openssl req -x509 -new -nodes \
  -key root/private/ca.key.pem \
  -sha256 -days 3650 \
  -out root/certs/ca.cert.pem \
  -subj "/CN=Demo Root CA/O=Example/C=US"

# Step 3: Generate Intermediate CA key
echo "[3/5] Generating Intermediate CA private key..."
openssl genrsa -out intermediate/private/intermediate.key.pem 4096

# Step 4: Create CSR for Intermediate CA
echo "[4/5] Creating Intermediate CA CSR..."
openssl req -new \
  -key intermediate/private/intermediate.key.pem \
  -out intermediate/csr/intermediate.csr.pem \
  -subj "/CN=Demo Intermediate CA/O=Example/C=US"

# Step 5: Sign Intermediate CA with Root CA
echo "[5/5] Signing Intermediate CA with Root CA..."
openssl x509 -req \
  -in intermediate/csr/intermediate.csr.pem \
  -CA root/certs/ca.cert.pem \
  -CAkey root/private/ca.key.pem \
  -CAcreateserial \
  -out intermediate/certs/intermediate.cert.pem \
  -days 1825 -sha256 \
  -extfile <(printf "basicConstraints=critical,CA:TRUE,pathlen:0\nkeyUsage=critical,keyCertSign,cRLSign")

echo ""
echo "=== PKI Hierarchy Built ==="
echo ""
echo "Verify the chain:"
openssl verify -CAfile root/certs/ca.cert.pem intermediate/certs/intermediate.cert.pem

echo ""
echo "Inspect the Root CA:"
openssl x509 -in root/certs/ca.cert.pem -noout -subject -issuer -dates

echo ""
echo "Inspect the Intermediate CA:"
openssl x509 -in intermediate/certs/intermediate.cert.pem -noout -subject -issuer -dates

echo ""
echo "Files created:"
echo "  root/certs/ca.cert.pem               - Root CA certificate"
echo "  root/private/ca.key.pem              - Root CA private key"
echo "  intermediate/certs/intermediate.cert.pem - Intermediate CA cert"
echo "  intermediate/private/intermediate.key.pem - Intermediate CA key"
echo ""
echo "Next: Lab 2 - Sign end-entity certificates"
