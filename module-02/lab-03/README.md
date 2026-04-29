# Lab 3 — Establishing mTLS Between Services

## Objective

Configure two services to mutually authenticate with certificates from lab-02.

## Run

```bash
# Terminal 1: start mTLS server
./mtls-server.sh

# Terminal 2: connect with mTLS client (succeeds — both have valid certs)
./mtls-client.sh

# Terminal 3: connect WITHOUT a cert (fails — server requires client cert)
./mtls-client-no-cert.sh
```
