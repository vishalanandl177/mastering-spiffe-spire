package ai_authz

# Default deny for AI infrastructure
default allow = false

# Customer support agent can call LLM and read knowledge base
allow {
    input.source_spiffe_id == "spiffe://ai.example.org/agent/customer-support"
    input.target_spiffe_id == "spiffe://ai.example.org/llm"
}

allow {
    input.source_spiffe_id == "spiffe://ai.example.org/agent/customer-support"
    input.target_spiffe_id == "spiffe://ai.example.org/vectordb"
    input.action == "read"
}

# Code review agent can call LLM but not vector DB
allow {
    input.source_spiffe_id == "spiffe://ai.example.org/agent/code-review"
    input.target_spiffe_id == "spiffe://ai.example.org/llm"
}

# Only privileged agents can use MCP servers (tool execution)
allow {
    input.source_spiffe_id == "spiffe://ai.example.org/agent/admin"
    input.target_spiffe_id == "spiffe://ai.example.org/mcp"
}

# Token budget enforcement
deny[msg] {
    input.target_spiffe_id == "spiffe://ai.example.org/llm"
    input.daily_token_count > 100000
    msg := sprintf("Agent %s exceeded daily token budget", [input.source_spiffe_id])
}
