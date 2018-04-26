local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local serviceAccount = k.core.v1.serviceAccount;

{
    kubernetes_objects+:: {
        "node-exporter/service-account":
            serviceAccount.new("node-exporter") +
              serviceAccount.mixin.metadata.withNamespace($._config.namespace)
    }
}
