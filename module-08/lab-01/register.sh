#!/bin/bash
set -e
spire-server entry create \
  -spiffeID spiffe://example.org/ns/default/sa/envoy \
  -parentID spiffe://example.org/agent \
  -selector docker:label:app:envoy
