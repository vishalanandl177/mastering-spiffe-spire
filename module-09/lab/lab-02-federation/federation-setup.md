# SPIFFE Federation Setup

Two trust domains federate to enable cross-cluster mTLS.

## Architecture

```
Trust Domain A: cluster-a.company.org   Trust Domain B: cluster-b.company.org
        │                                       │
        └────── Bundle Exchange ────────────────┘
                  (HTTPS)
```

## Cluster A Server Config

```hcl
server {
    trust_domain = "cluster-a.company.org"

    federation {
        bundle_endpoint {
            address = "0.0.0.0"
            port = 8443
        }
    }
}
```

## Cluster B Server Config

```hcl
server {
    trust_domain = "cluster-b.company.org"

    federation {
        bundle_endpoint {
            address = "0.0.0.0"
            port = 8443
        }

        federates_with "cluster-a.company.org" {
            bundle_endpoint_url = "https://spire-server.cluster-a.example.com:8443"
            bundle_endpoint_profile "https_spiffe" {
                endpoint_spiffe_id = "spiffe://cluster-a.company.org/spire/server"
            }
        }
    }
}
```

## Steps

```bash
# 1. On Cluster A: export bundle
spire-server bundle show > cluster-a-bundle.pem

# 2. On Cluster B: import bundle
spire-server bundle set \
  -id spiffe://cluster-a.company.org \
  -path cluster-a-bundle.pem

# 3. Repeat in reverse for bidirectional federation

# 4. Register a federated workload
spire-server entry create \
  -spiffeID spiffe://cluster-b.company.org/ns/default/sa/api \
  -federatesWith spiffe://cluster-a.company.org \
  -selector k8s:ns:default \
  -selector k8s:sa:api
```

## Verification

```bash
# Cluster A workload should accept cluster B SVID
# In cluster A workload:
curl --cert /spiffe/svid.pem --key /spiffe/key.pem \
  --cacert /spiffe/bundle.pem \
  https://api.cluster-b.example.com/
```
