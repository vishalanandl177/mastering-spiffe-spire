package ai_authz

default allow = false

# Customer support agent can call the LLM (read only)
allow if {
    input.source_spiffe_id == "spiffe://example.org/ai/agent/customer-support"
    input.target_spiffe_id == "spiffe://example.org/ai/llm/gpt-proxy"
    input.request_method == "POST"
    input.request_path == "/v1/chat/completions"
}

# Customer support can query vector DB
allow if {
    input.source_spiffe_id == "spiffe://example.org/ai/agent/customer-support"
    input.target_spiffe_id == "spiffe://example.org/ai/vectordb"
    input.request_method == "GET"
}

# Customer support CANNOT modify embeddings (read-only role)
deny[msg] if {
    input.source_spiffe_id == "spiffe://example.org/ai/agent/customer-support"
    input.target_spiffe_id == "spiffe://example.org/ai/vectordb"
    input.request_method == "POST"
    msg := "Customer support agents cannot write to vector DB"
}

# Internal training pipeline CAN modify embeddings
allow if {
    input.source_spiffe_id == "spiffe://example.org/ai/pipeline/training"
    input.target_spiffe_id == "spiffe://example.org/ai/vectordb"
}
