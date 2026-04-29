#!/bin/bash
set -e

# Register the AI agent
spire-server entry create \
  -spiffeID spiffe://example.org/ai/agent/customer-support \
  -parentID spiffe://example.org/agent \
  -selector docker:label:app:ai-agent

# Register the LLM service
spire-server entry create \
  -spiffeID spiffe://example.org/ai/llm/gpt-proxy \
  -parentID spiffe://example.org/agent \
  -selector docker:label:app:llm-service

# Register the vector database
spire-server entry create \
  -spiffeID spiffe://example.org/ai/vectordb \
  -parentID spiffe://example.org/agent \
  -selector docker:label:app:vector-db

echo "✓ AI workloads registered"
