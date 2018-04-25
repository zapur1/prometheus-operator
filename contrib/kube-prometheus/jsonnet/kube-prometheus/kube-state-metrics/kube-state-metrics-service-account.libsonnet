local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local serviceAccount = k.core.v1.serviceAccount;

{
    kubernetes_objects+:: {
        "kube-state-metrics/service-account":
            serviceAccount.new("kube-state-metrics") +
              serviceAccount.mixin.metadata.withNamespace($._config.namespace)
    }
}
