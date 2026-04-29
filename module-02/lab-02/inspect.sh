#!/bin/bash
set -e
SERVICE=${1:-service-a}
cd ca
echo "=== SVID for $SERVICE ==="
openssl x509 -in "$SERVICE.crt" -noout -text | grep -A1 "Subject Alternative"
openssl x509 -in "$SERVICE.crt" -noout -dates
