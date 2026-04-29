package authz

default allow = false

# orders-api can read orders
allow if {
    input.source_spiffe_id == "spiffe://example.org/ns/default/sa/orders-api"
    input.request_method == "GET"
    startswith(input.request_path, "/api/orders")
}

# admin has full access
allow if {
    input.source_spiffe_id == "spiffe://example.org/ns/default/sa/admin"
}

# Deny everything else (default allow = false)
