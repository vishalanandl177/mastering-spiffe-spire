#!/bin/bash
# Inspect X.509-SVID and JWT-SVID structures
set -e

echo "=== Inspecting SVID Formats ==="
echo ""

# Use cert from Module 2 Lab 2
SVID="../../../module-02/lab/lab-02-cert-signing/svids/service-a.cert.pem"

if [ ! -f "$SVID" ]; then
  echo "Run Module 2 Lab 2 first to generate a sample X.509-SVID"
  exit 1
fi

echo "=== X.509-SVID ==="
echo ""
echo "Certificate fields:"
openssl x509 -in "$SVID" -noout -subject -issuer -dates

echo ""
echo "Subject Alternative Name (SPIFFE ID is here):"
openssl x509 -in "$SVID" -noout -ext subjectAltName

echo ""
echo "Full X.509 structure:"
openssl x509 -in "$SVID" -noout -text | head -30

echo ""
echo "=== JWT-SVID Example (would be issued by SPIRE) ==="
echo ""
echo "JWT-SVID is a signed JWT with SPIFFE ID in 'sub' claim:"
echo ""
echo 'Header (decoded):'
echo '{'
echo '  "alg": "ES256",'
echo '  "kid": "<key-id>",'
echo '  "typ": "JWT"'
echo '}'
echo ""
echo 'Payload (decoded):'
echo '{'
echo '  "aud": ["audience"],'
echo '  "exp": 1714233600,'
echo '  "iat": 1714230000,'
echo '  "sub": "spiffe://example.org/ns/default/sa/service-a"'
echo '}'

echo ""
echo "=== Comparison ==="
echo "  X.509-SVID:"
echo "    - Used for mTLS connections"
echo "    - Includes private key for signing TLS handshake"
echo "    - SPIFFE ID in URI SAN"
echo "  JWT-SVID:"
echo "    - Used for HTTP APIs (passed in Authorization header)"
echo "    - No private key — already signed by SPIRE"
echo "    - SPIFFE ID in 'sub' claim"
