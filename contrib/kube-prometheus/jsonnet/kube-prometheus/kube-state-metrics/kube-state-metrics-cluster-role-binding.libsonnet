local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local clusterRoleBinding = k.rbac.v1.clusterRoleBinding;

{
    kubernetes_objects+:: {
        "kube-state-metrics/cluster-role-binding":
            clusterRoleBinding.new() +
              clusterRoleBinding.mixin.metadata.withName("kube-state-metrics") +
              clusterRoleBinding.mixin.roleRef.withApiGroup("rbac.authorization.k8s.io") +
              clusterRoleBinding.mixin.roleRef.withName("kube-state-metrics") +
              clusterRoleBinding.mixin.roleRef.mixinInstance({kind: "ClusterRole"}) +
              clusterRoleBinding.withSubjects([{kind: "ServiceAccount", name: "kube-state-metrics", namespace: $._config.namespace}])
    }
}
