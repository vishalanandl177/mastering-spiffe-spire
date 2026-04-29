package authz

# Default deny — zero trust principle
default allow = false

# Allow orders-api to read orders
allow {
    input.source_spiffe_id == "spiffe://example.org/ns/default/sa/orders-api"
    input.request_method == "GET"
    startswith(input.request_path, "/api/orders")
}

# Allow payments service to call billing
allow {
    input.source_spiffe_id == "spiffe://example.org/ns/payments/sa/payment-processor"
    input.target_spiffe_id == "spiffe://example.org/ns/billing/sa/billing-service"
}

# Admin service has full access
allow {
    input.source_spiffe_id == "spiffe://example.org/ns/admin/sa/admin-service"
}

# Time-based access: maintenance only during business hours
allow {
    input.source_spiffe_id == "spiffe://example.org/ns/ops/sa/maintenance"
    time.now_ns() >= time.parse_rfc3339_ns(input.business_hours_start)
    time.now_ns() <= time.parse_rfc3339_ns(input.business_hours_end)
}
