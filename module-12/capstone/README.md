# Capstone: Production-Grade Zero Trust Platform

## What You Will Build

```
Cluster A (Production)              Cluster B (Staging)
├── SPIRE Server (HA)               ├── SPIRE Server (HA)
├── SPIRE Agent (DaemonSet)         ├── SPIRE Agent (DaemonSet)
├── Frontend + Envoy                ├── Frontend + Envoy
├── API + Envoy                     ├── API + Envoy
├── Orders + Envoy                  └── OPA + Prometheus
├── Payments + Envoy
├── OPA + Prometheus
└── Grafana

         <----- Federation ----->
        (Cross-cluster mTLS via SPIFFE)
```

## Run

```bash
./00-setup-clusters.sh
./01-deploy-spire-ha.sh
./02-deploy-applications.sh
./03-deploy-envoy-sidecars.sh
./04-deploy-opa-policies.sh
./05-setup-federation.sh
./06-deploy-monitoring.sh
./07-test-zero-trust.sh
```

After running all scripts, you will have a fully functioning zero trust platform that you can use as a reference architecture for your organization.
