local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";

local alertmanagerConfig = "
global:
  resolve_timeout: 5m
route:
  group_by: ['job']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 12h
  receiver: 'null'
  routes:
  - match:
      alertname: DeadMansSwitch
    receiver: 'null'
receivers:
- name: 'null'
";

{
    _config+:: {
        namespace: "monitoring",
        alertmanagerConfig: alertmanagerConfig,

        kube_state_metrics_selector: 'job="kube-state-metrics"',
        cadvisor_selector: 'job="kubelet"',
        node_exporter_selector: 'job="node-exporter"',
        kubelet_selector: 'job="kubelet"',
        not_kube_dns_selector: 'job!="kube-dns"',
    },
} +
(import "grafana/grafana.libsonnet") +
(import "kube-state-metrics/kube-state-metrics.libsonnet") +
(import "node-exporter/node-exporter.libsonnet") +
(import "alertmanager/alertmanager.libsonnet") +
(import "prometheus-operator/prometheus-operator.libsonnet") +
(import "prometheus/prometheus.libsonnet") +
(import "kubernetes-mixin/mixin.libsonnet")
