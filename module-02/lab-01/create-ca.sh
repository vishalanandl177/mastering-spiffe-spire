#!/bin/bash
set -e
mkdir -p ca && cd ca

# Generate Root CA private key
openssl genrsa -out root-ca.key 4096

# Generate self-signed Root CA certificate
openssl req -x509 -new -nodes -key root-ca.key -sha256 -days 3650 \
  -subj "/CN=Demo Root CA/O=CodersSecret/C=US" \
  -out root-ca.crt

# Generate Intermediate CA private key
openssl genrsa -out int-ca.key 4096

# Generate Intermediate CA CSR
openssl req -new -key int-ca.key \
  -subj "/CN=Demo Intermediate CA/O=CodersSecret/C=US" \
  -out int-ca.csr

# Sign Intermediate CA with Root CA
cat > int-ca.ext <<EXT
basicConstraints=CA:TRUE,pathlen:0
keyUsage=keyCertSign,cRLSign
EXT

openssl x509 -req -in int-ca.csr \
  -CA root-ca.crt -CAkey root-ca.key -CAcreateserial \
  -days 1825 -sha256 -extfile int-ca.ext \
  -out int-ca.crt

echo "✓ Root CA and Intermediate CA created"
ls -la
