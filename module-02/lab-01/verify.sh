#!/bin/bash
set -e
cd ca
echo "=== Root CA ==="
openssl x509 -in root-ca.crt -noout -subject -issuer -dates
echo
echo "=== Intermediate CA ==="
openssl x509 -in int-ca.crt -noout -subject -issuer -dates
echo
echo "=== Verifying chain ==="
openssl verify -CAfile root-ca.crt int-ca.crt
