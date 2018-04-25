{
    kubernetes_objects+:: {
        "prometheus-operator/service-monitor":
            {
                "apiVersion": "monitoring.coreos.com/v1",
                "kind": "ServiceMonitor",
                "metadata": {
                    "name": "prometheus-operator",
                    "namespace": $._config.namespace,
                    "labels": {
                        "k8s-app": "prometheus-operator"
                    }
                },
                "spec": {
                    "endpoints": [
                        {
                            "port": "http"
                        }
                    ],
                    "selector": {
                        "matchLabels": {
                            "k8s-app": "prometheus-operator"
                        }
                    }
                }
            }
    }
}
