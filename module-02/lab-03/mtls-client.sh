#!/bin/bash
set -e
cd ../lab-02/ca
openssl s_client -connect localhost:8443 \
  -cert service-a.crt -key service-a.key \
  -CAfile root-ca.crt \
  -verify_return_error
