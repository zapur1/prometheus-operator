{
    kubernetes_objects+:: {
        "kube-state-metrics/service-monitor":
            {
                "apiVersion": "monitoring.coreos.com/v1",
                "kind": "ServiceMonitor",
                "metadata": {
                    "name": "kube-state-metrics",
                    "namespace": $._config.namespace,
                    "labels": {
                        "k8s-app": "kube-state-metrics"
                    }
                },
                "spec": {
                    "jobLabel": "k8s-app",
                    "selector": {
                        "matchLabels": {
                            "k8s-app": "kube-state-metrics"
                        }
                    },
                    "namespaceSelector": {
                        "matchNames": [
                            "monitoring"
                        ]
                    },
                    "endpoints": [
                        {
                            "port": "https-main",
                            "scheme": "https",
                            "interval": "30s",
                            "honorLabels": true,
                            "bearerTokenFile": "/var/run/secrets/kubernetes.io/serviceaccount/token",
                            "tlsConfig": {
                                "insecureSkipVerify": true
                            }
                        },
                        {
                            "port": "https-self",
                            "scheme": "https",
                            "interval": "30s",
                            "bearerTokenFile": "/var/run/secrets/kubernetes.io/serviceaccount/token",
                            "tlsConfig": {
                                "insecureSkipVerify": true
                            }
                        }
                    ]
                }
            }
    }
}
