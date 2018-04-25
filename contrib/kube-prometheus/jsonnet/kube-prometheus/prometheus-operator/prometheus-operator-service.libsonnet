local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

{
    kubernetes_objects+:: {
        "prometheus-operator/service":
            local poServicePort = servicePort.newNamed("http", 8080, "http");

            service.new("prometheus-operator", $.kubernetes_objects["prometheus-operator/deployment"].spec.selector.matchLabels, [poServicePort]) +
            service.mixin.metadata.withNamespace($._config.namespace)
    }
}
