local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local roleBinding = k.rbac.v1.roleBinding;

{
    kubernetes_objects+:: {
        "kube-state-metrics/role-binding":
            roleBinding.new() +
              roleBinding.mixin.metadata.withName("kube-state-metrics") +
              roleBinding.mixin.metadata.withNamespace($._config.namespace) +
              roleBinding.mixin.roleRef.withApiGroup("rbac.authorization.k8s.io") +
              roleBinding.mixin.roleRef.withName("kube-state-metrics") +
              roleBinding.mixin.roleRef.mixinInstance({kind: "Role"}) +
              roleBinding.withSubjects([{kind: "ServiceAccount", name: "kube-state-metrics"}])
    }
}
