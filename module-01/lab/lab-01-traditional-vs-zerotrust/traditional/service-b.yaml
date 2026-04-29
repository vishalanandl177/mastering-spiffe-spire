apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-b
  labels:
    app: service-b
spec:
  replicas: 1
  selector:
    matchLabels:
      app: service-b
  template:
    metadata:
      labels:
        app: service-b
    spec:
      containers:
      - name: service-b
        image: hashicorp/http-echo:latest
        args:
          - "-text={\"data\": \"sensitive\", \"message\": \"NO IDENTITY VERIFICATION!\"}"
        ports:
        - containerPort: 5678
---
apiVersion: v1
kind: Service
metadata:
  name: service-b
spec:
  selector:
    app: service-b
  ports:
  - port: 80
    targetPort: 5678
