# Lab 1 — Monitoring SPIRE with Prometheus + Grafana

```bash
kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f grafana-deployment.yaml
# Open http://localhost:3000 (admin/admin) and import dashboard.json
```
