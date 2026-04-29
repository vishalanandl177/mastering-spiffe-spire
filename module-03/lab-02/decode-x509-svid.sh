#!/bin/bash
# Decode an X.509-SVID and show the SPIFFE ID in the SAN field
CERT=${1:-../../module-02/lab-02/ca/service-a.crt}
echo "=== X.509-SVID Inspection ==="
openssl x509 -in "$CERT" -noout -text | grep -A2 "Subject Alternative\|Validity\|Subject:"
