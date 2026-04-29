#!/bin/bash
# Validate a SPIFFE ID against the spec
SPIFFE_ID=$1
[ -z "$SPIFFE_ID" ] && echo "Usage: $0 <spiffe-id>" && exit 1

if [[ ! "$SPIFFE_ID" =~ ^spiffe://[a-z0-9.-]+(/[A-Za-z0-9._-]+)*$ ]]; then
  echo "✗ Invalid: $SPIFFE_ID"
  echo "  Format: spiffe://trust-domain/path"
  exit 1
fi

echo "✓ Valid SPIFFE ID: $SPIFFE_ID"
TD=$(echo "$SPIFFE_ID" | sed 's|spiffe://||;s|/.*||')
PATH_PART=$(echo "$SPIFFE_ID" | sed "s|spiffe://$TD||")
echo "  Trust Domain: $TD"
echo "  Path:         $PATH_PART"
