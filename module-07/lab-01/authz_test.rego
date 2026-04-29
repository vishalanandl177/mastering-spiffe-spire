package authz

test_orders_api_can_read if {
    allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/orders-api",
        "request_method": "GET",
        "request_path": "/api/orders/123"
    }
}

test_orders_api_cannot_delete_users if {
    not allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/orders-api",
        "request_method": "DELETE",
        "request_path": "/api/users/456"
    }
}

test_admin_can_do_anything if {
    allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/admin",
        "request_method": "DELETE",
        "request_path": "/api/anything"
    }
}

test_unknown_service_denied if {
    not allow with input as {
        "source_spiffe_id": "spiffe://example.org/ns/default/sa/random",
        "request_method": "GET",
        "request_path": "/api/orders"
    }
}
