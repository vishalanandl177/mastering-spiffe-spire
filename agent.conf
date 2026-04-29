#!/bin/bash
# Lab 3: mTLS between Go server and client
set -e

echo "=== Lab 3: mTLS Communication ==="
echo ""

mkdir -p certs

# Generate CA
openssl req -x509 -newkey rsa:2048 -keyout certs/ca.key -out certs/ca.crt \
  -days 365 -nodes -subj "/CN=Demo CA"

# Generate server cert with SPIFFE ID
openssl req -newkey rsa:2048 -keyout certs/server.key -out certs/server.csr \
  -nodes -subj "/CN=localhost"

cat > certs/server.ext <<EOF
subjectAltName = DNS:localhost, URI:spiffe://example.org/ns/default/sa/server
EOF

openssl x509 -req -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key \
  -CAcreateserial -out certs/server.crt -days 365 -extfile certs/server.ext

# Generate client cert with SPIFFE ID
openssl req -newkey rsa:2048 -keyout certs/client.key -out certs/client.csr \
  -nodes -subj "/CN=client"

cat > certs/client.ext <<EOF
subjectAltName = URI:spiffe://example.org/ns/default/sa/client
EOF

openssl x509 -req -in certs/client.csr -CA certs/ca.crt -CAkey certs/ca.key \
  -CAcreateserial -out certs/client.crt -days 365 -extfile certs/client.ext

echo "Certificates generated."
echo ""
echo "Run server in one terminal:  go run server.go"
echo "Run client in another:       go run client.go"
echo ""
echo "Expected output: 'Hello from server! Client SPIFFE ID: spiffe://example.org/ns/default/sa/client'"
