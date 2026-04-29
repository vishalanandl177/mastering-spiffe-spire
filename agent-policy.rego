apiVersion: v1
kind: ServiceAccount
metadata:
  name: spire-server
  namespace: spire
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: spire-server-role
rules:
  - apiGroups: [""]
    resources: ["nodes", "pods"]
    verbs: ["get", "list"]
  - apiGroups: ["authentication.k8s.io"]
    resources: ["tokenreviews"]
    verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: spire-server-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: spire-server-role
subjects:
  - kind: ServiceAccount
    name: spire-server
    namespace: spire
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: spire-server-config
  namespace: spire
data:
  server.conf: |
    server {
      bind_address = "0.0.0.0"
      bind_port = "8081"
      socket_path = "/tmp/spire-server/private/api.sock"
      trust_domain = "example.org"
      data_dir = "/run/spire/data"
      log_level = "INFO"
      ca_subject = {
        country = ["US"],
        organization = ["Demo"],
        common_name = "spire-ca",
      }
    }

    plugins {
      DataStore "sql" {
        plugin_data {
          database_type = "sqlite3"
          connection_string = "/run/spire/data/datastore.sqlite3"
        }
      }
      KeyManager "disk" {
        plugin_data {
          keys_path = "/run/spire/data/keys.json"
        }
      }
      NodeAttestor "k8s_psat" {
        plugin_data {
          clusters = {
            "demo-cluster" = {
              service_account_allow_list = ["spire:spire-agent"]
            }
          }
        }
      }
    }
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: spire-server
  namespace: spire
  labels:
    app: spire-server
spec:
  replicas: 1
  serviceName: spire-server
  selector:
    matchLabels:
      app: spire-server
  template:
    metadata:
      labels:
        app: spire-server
    spec:
      serviceAccountName: spire-server
      containers:
        - name: spire-server
          image: ghcr.io/spiffe/spire-server:1.9.6
          args:
            - -config
            - /run/spire/config/server.conf
          ports:
            - containerPort: 8081
          volumeMounts:
            - name: spire-config
              mountPath: /run/spire/config
              readOnly: true
            - name: spire-data
              mountPath: /run/spire/data
      volumes:
        - name: spire-config
          configMap:
            name: spire-server-config
        - name: spire-data
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: spire-server
  namespace: spire
spec:
  type: ClusterIP
  selector:
    app: spire-server
  ports:
    - name: grpc
      port: 8081
      targetPort: 8081
      protocol: TCP
