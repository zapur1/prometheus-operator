local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local serviceAccount = k.core.v1.serviceAccount;

{
    kubernetes_objects+:: {
        "prometheus-operator/service-account":
            serviceAccount.new("prometheus-operator") +
              serviceAccount.mixin.metadata.withNamespace($._config.namespace)
    }
}
