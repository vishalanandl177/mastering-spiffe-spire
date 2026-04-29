apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-a
  labels:
    app: service-a
spec:
  replicas: 1
  selector:
    matchLabels:
      app: service-a
  template:
    metadata:
      labels:
        app: service-a
    spec:
      containers:
      - name: service-a
        image: curlimages/curl:latest
        command: ["sleep", "3600"]
---
apiVersion: v1
kind: Service
metadata:
  name: service-a
spec:
  selector:
    app: service-a
  ports:
  - port: 80
    targetPort: 8080
