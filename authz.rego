server {
    bind_address = "0.0.0.0"
    bind_port = "8081"
    socket_path = "/tmp/spire-server/private/api.sock"
    trust_domain = "example.org"
    data_dir = "./data/server"
    log_level = "DEBUG"
    ca_subject = {
        country = ["US"],
        organization = ["Demo"],
        common_name = "Demo SPIRE Server",
    }
}

plugins {
    DataStore "sql" {
        plugin_data {
            database_type = "sqlite3"
            connection_string = "./data/server/datastore.sqlite3"
        }
    }

    KeyManager "memory" {
        plugin_data = {}
    }

    NodeAttestor "join_token" {
        plugin_data {}
    }
}
