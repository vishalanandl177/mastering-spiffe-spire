#!/bin/bash
set -e
cd ../lab-02/ca
openssl s_server -accept 8443 \
  -cert service-b.crt -key service-b.key \
  -CAfile root-ca.crt \
  -Verify 1 \
  -www
