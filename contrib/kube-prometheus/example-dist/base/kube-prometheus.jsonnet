local kubePrometheus = (import "kube-prometheus/kube-prometheus.libsonnet") + {
    _config+:: {
        namespace: "monitoring",
    }
};

{[path+".yaml"]: std.manifestYamlDoc(kubePrometheus.kubernetes_objects[path]) for path in std.objectFields(kubePrometheus.kubernetes_objects)}
