package authz

test_orders_api_can_read_orders {
    allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/orders-api",
        "request_method": "GET",
        "request_path": "/api/orders/123",
    }
}

test_orders_api_cannot_delete_users {
    not allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/orders-api",
        "request_method": "DELETE",
        "request_path": "/api/users/456",
    }
}

test_unknown_service_denied {
    not allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/unknown",
        "request_method": "GET",
        "request_path": "/api/orders",
    }
}

test_admin_has_full_access {
    allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/admin/sa/admin-service",
        "request_method": "DELETE",
        "request_path": "/api/anything",
    }
}
