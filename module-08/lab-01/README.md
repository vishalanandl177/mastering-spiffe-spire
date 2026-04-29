# Lab 1 — SPIRE with Envoy via SDS

Configure Envoy to fetch certificates from the SPIRE Workload API using the Secret Discovery Service.

## Files

- `envoy-spire-sds.yaml` — Envoy bootstrap config with SDS pointing to SPIRE
- `register.sh` — Register Envoy as a SPIRE workload

## Run

```bash
./register.sh
docker run --rm -v $(pwd):/etc/envoy -v /run/spire/sockets:/run/spire/sockets \
  envoyproxy/envoy:v1.29-latest -c /etc/envoy/envoy-spire-sds.yaml
```
