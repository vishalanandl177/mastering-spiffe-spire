#!/bin/bash
set -e
echo "=== Testing service-to-service connectivity ==="
kubectl exec deploy/service-a -- curl -s -o /dev/null -w "service-a -> service-b: %{http_code}\n" http://service-b
echo "Note: Network policies restrict by namespace/labels, NOT cryptographic identity"
echo "An attacker who compromises a pod with the right labels can still impersonate service-a"
