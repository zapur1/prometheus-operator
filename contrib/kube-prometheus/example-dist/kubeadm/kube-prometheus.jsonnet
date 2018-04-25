local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

local controllerManagerService = service.new("kube-controller-manager-prometheus-discovery", {component: "kube-controller-manager"}, servicePort.newNamed("http-metrics", 10252, 10252)) +
  service.mixin.metadata.withNamespace("kube-system") +
  service.mixin.metadata.withLabels({"k8s-app": "kube-controller-manager"});

local schedulerService = service.new("kube-scheduler-prometheus-discovery", {component: "kube-scheduler"}, servicePort.newNamed("http-metrics", 10251, 10251)) +
  service.mixin.metadata.withNamespace("kube-system") +
  service.mixin.metadata.withLabels({"k8s-app": "kube-scheduler"});

local kube_prometheus = (import "kube-prometheus/kube-prometheus.libsonnet") +
    {
        kubernetes_objects+:: {
            "prometheus/service"+:
                service.mixin.spec.withPorts(servicePort.newNamed("web", 9090, "web") + servicePort.withNodePort(30900)) +
                service.mixin.spec.withType("NodePort"),
            "alertmanager/service"+:
                service.mixin.spec.withPorts(servicePort.newNamed("web", 9093, "web") + servicePort.withNodePort(30903)) +
                service.mixin.spec.withType("NodePort"),
            "grafana/service"+:
                service.mixin.spec.withPorts(servicePort.newNamed("http", 3000, "http") + servicePort.withNodePort(30902)) +
                service.mixin.spec.withType("NodePort"),
            "prometheus/kube-controller-manager-prometheus-discovery-service": controllerManagerService,
            "prometheus/kube-scheduler-prometheus-discovery-service": schedulerService,
        },
        _config+:: {
            namespace: "monitoring",
        }
    };

{[path+".yaml"]: std.manifestYamlDoc(kube_prometheus.kubernetes_objects[path]) for path in std.objectFields(kube_prometheus.kubernetes_objects)}
