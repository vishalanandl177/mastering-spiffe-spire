# Lab 1 — SPIRE in HA Mode with PostgreSQL

```bash
kubectl apply -f postgres.yaml
kubectl apply -f spire-server-ha.yaml
kubectl scale -n spire statefulset/spire-server --replicas=3
```
