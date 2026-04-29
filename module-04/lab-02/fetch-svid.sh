#!/bin/bash
set -e
../lab-01/spire/bin/spire-agent api fetch x509 \
  -socketPath /tmp/spire-agent/public/api.sock \
  -write ./svid

echo "✓ SVID written to ./svid"
ls -la ./svid
echo
echo "=== SVID details ==="
openssl x509 -in ./svid/svid.0.pem -noout -subject -issuer -dates -ext subjectAltName
