{
    kubernetes_objects+:: {
        "prometheus/service-monitor-kube-controller-manager":
            {
                "apiVersion": "monitoring.coreos.com/v1",
                "kind": "ServiceMonitor",
                "metadata": {
                    "name": "kube-controller-manager",
                    "namespace": $._config.namespace,
                    "labels": {
                        "k8s-app": "kube-controller-manager"
                    }
                },
                "spec": {
                    "jobLabel": "k8s-app",
                    "endpoints": [
                        {
                            "port": "http-metrics",
                            "interval": "30s"
                        }
                    ],
                    "selector": {
                        "matchLabels": {
                            "k8s-app": "kube-controller-manager"
                        }
                    },
                    "namespaceSelector": {
                        "matchNames": [
                            "kube-system"
                        ]
                    }
                }
            }
    }
}
