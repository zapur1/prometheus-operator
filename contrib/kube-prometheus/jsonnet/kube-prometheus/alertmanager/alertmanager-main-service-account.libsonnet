local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local serviceAccount = k.core.v1.serviceAccount;

{
    kubernetes_objects+:: {
        "alertmanager/service-account":
            serviceAccount.new("alertmanager-main") +
              serviceAccount.mixin.metadata.withNamespace($._config.namespace)
    }
}
