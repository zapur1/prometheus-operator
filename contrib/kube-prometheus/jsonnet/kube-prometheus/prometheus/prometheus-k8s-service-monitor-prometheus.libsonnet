{
    kubernetes_objects+:: {
        "prometheus/service-monitor-prometheus":
            {
                "apiVersion": "monitoring.coreos.com/v1",
                "kind": "ServiceMonitor",
                "metadata": {
                    "name": "prometheus",
                    "namespace": $._config.namespace,
                    "labels": {
                        "k8s-app": "prometheus"
                    }
                },
                "spec": {
                    "selector": {
                        "matchLabels": {
                            "prometheus": "k8s"
                        }
                    },
                    "namespaceSelector": {
                        "matchNames": [
                            "monitoring"
                        ]
                    },
                    "endpoints": [
                        {
                            "port": "web",
                            "interval": "30s"
                        }
                    ]
                }
            }
    }
}
