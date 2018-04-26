local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local clusterRole = k.rbac.v1.clusterRole;
local policyRule = clusterRole.rulesType;

{
    kubernetes_objects+:: {
        "prometheus-operator/cluster-role":
            local extensionsRule = policyRule.new() +
              policyRule.withApiGroups(["extensions"]) +
              policyRule.withResources([
                "thirdpartyresources",
              ]) +
              policyRule.withVerbs(["*"]);

            local apiExtensionsRule = policyRule.new() +
              policyRule.withApiGroups(["apiextensions.k8s.io"]) +
              policyRule.withResources([
                "customresourcedefinitions",
              ]) +
              policyRule.withVerbs(["*"]);

            local monitoringRule = policyRule.new() +
              policyRule.withApiGroups(["monitoring.coreos.com"]) +
              policyRule.withResources([
                "alertmanagers",
                "prometheuses",
                "prometheuses/finalizers",
                "alertmanagers/finalizers",
                "servicemonitors",
              ]) +
              policyRule.withVerbs(["*"]);

            local appsRule = policyRule.new() +
              policyRule.withApiGroups(["apps"]) +
              policyRule.withResources([
                "statefulsets",
              ]) +
              policyRule.withVerbs(["*"]);

            local coreRule = policyRule.new() +
              policyRule.withApiGroups([""]) +
              policyRule.withResources([
                "configmaps",
                "secrets",
              ]) +
              policyRule.withVerbs(["*"]);

            local podRule = policyRule.new() +
              policyRule.withApiGroups([""]) +
              policyRule.withResources([
                "pods",
              ]) +
              policyRule.withVerbs(["list", "delete"]);

            local routingRule = policyRule.new() +
              policyRule.withApiGroups([""]) +
              policyRule.withResources([
                "services",
                "endpoints",
              ]) +
              policyRule.withVerbs(["get", "create", "update"]);

            local nodeRule = policyRule.new() +
              policyRule.withApiGroups([""]) +
              policyRule.withResources([
                "nodes",
              ]) +
              policyRule.withVerbs(["list", "watch"]);

            local namespaceRule = policyRule.new() +
              policyRule.withApiGroups([""]) +
              policyRule.withResources([
                "namespaces",
              ]) +
              policyRule.withVerbs(["list"]);

            local rules = [extensionsRule, apiExtensionsRule, monitoringRule, appsRule, coreRule, podRule, routingRule, nodeRule, namespaceRule];

            clusterRole.new() +
              clusterRole.mixin.metadata.withName("prometheus-operator") +
              clusterRole.withRules(rules)
    }
}
