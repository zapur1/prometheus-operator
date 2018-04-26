{
    kubernetes_objects+:: {
        "alertmanager/alertmanager":
            {
              apiVersion: "monitoring.coreos.com/v1",
              kind: "Alertmanager",
              metadata: {
                name: "main",
                namespace: $._config.namespace,
                labels: {
                  alertmanager: "main",
                },
              },
              spec: {
                replicas: 3,
                version: "v0.14.0",
                serviceAccountName: "alertmanager-main",
              },
            }
    }
}
