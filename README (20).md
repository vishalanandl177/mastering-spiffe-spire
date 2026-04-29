# ClusterSPIFFEID resource for automatic workload registration
# Uses SPIRE Controller Manager
apiVersion: spire.spiffe.io/v1alpha1
kind: ClusterSPIFFEID
metadata:
  name: default-workloads
spec:
  # Template for SPIFFE IDs assigned to matching pods
  spiffeIDTemplate: "spiffe://example.org/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}"

  # Match all pods except in system namespaces
  podSelector:
    matchLabels: {}

  namespaceSelector:
    matchExpressions:
      - key: kubernetes.io/metadata.name
        operator: NotIn
        values:
          - kube-system
          - kube-public
          - kube-node-lease
          - spire

  # SVID TTL — short for security, long for fewer rotations
  ttl: 1h
