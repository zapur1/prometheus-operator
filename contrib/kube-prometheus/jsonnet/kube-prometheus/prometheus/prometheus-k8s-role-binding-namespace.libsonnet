local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local roleBinding = k.rbac.v1.roleBinding;

{
    kubernetes_objects+:: {
        "prometheus/role-binding-namespace":
            roleBinding.new() +
              roleBinding.mixin.metadata.withName("prometheus-k8s") +
              roleBinding.mixin.metadata.withNamespace($._config.namespace) +
              roleBinding.mixin.roleRef.withApiGroup("rbac.authorization.k8s.io") +
              roleBinding.mixin.roleRef.withName("prometheus-k8s") +
              roleBinding.mixin.roleRef.mixinInstance({kind: "Role"}) +
              roleBinding.withSubjects([{kind: "ServiceAccount", name: "prometheus-k8s", namespace: $._config.namespace}])
    }
}
