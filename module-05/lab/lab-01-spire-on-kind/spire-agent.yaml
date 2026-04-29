apiVersion: v1
kind: ServiceAccount
metadata:
  name: spire-agent
  namespace: spire
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: spire-agent-role
rules:
  - apiGroups: [""]
    resources: ["pods", "nodes", "nodes/proxy"]
    verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: spire-agent-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: spire-agent-role
subjects:
  - kind: ServiceAccount
    name: spire-agent
    namespace: spire
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: spire-agent-config
  namespace: spire
data:
  agent.conf: |
    agent {
      data_dir = "/run/spire"
      log_level = "INFO"
      server_address = "spire-server"
      server_port = "8081"
      socket_path = "/run/spire/sockets/agent.sock"
      trust_bundle_path = "/run/spire/bundle/bundle.crt"
      trust_domain = "example.org"
    }

    plugins {
      KeyManager "memory" {
        plugin_data {}
      }
      NodeAttestor "k8s_psat" {
        plugin_data {
          cluster = "demo-cluster"
        }
      }
      WorkloadAttestor "k8s" {
        plugin_data {
          skip_kubelet_verification = true
        }
      }
      WorkloadAttestor "unix" {
        plugin_data {}
      }
    }
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: spire-agent
  namespace: spire
  labels:
    app: spire-agent
spec:
  selector:
    matchLabels:
      app: spire-agent
  template:
    metadata:
      labels:
        app: spire-agent
    spec:
      serviceAccountName: spire-agent
      hostPID: true
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      initContainers:
        - name: init-bundle
          image: ghcr.io/spiffe/spire-agent:1.9.6
          command:
            - /bin/sh
            - -c
            - |
              kubectl exec -n spire spire-server-0 -- \
                /opt/spire/bin/spire-server bundle show > /run/spire/bundle/bundle.crt || \
                echo "Bundle will be fetched at runtime"
          volumeMounts:
            - name: spire-bundle
              mountPath: /run/spire/bundle
      containers:
        - name: spire-agent
          image: ghcr.io/spiffe/spire-agent:1.9.6
          args:
            - -config
            - /run/spire/config/agent.conf
          volumeMounts:
            - name: spire-config
              mountPath: /run/spire/config
              readOnly: true
            - name: spire-bundle
              mountPath: /run/spire/bundle
            - name: spire-agent-socket
              mountPath: /run/spire/sockets
      volumes:
        - name: spire-config
          configMap:
            name: spire-agent-config
        - name: spire-bundle
          emptyDir: {}
        - name: spire-agent-socket
          hostPath:
            path: /run/spire/sockets
            type: DirectoryOrCreate
