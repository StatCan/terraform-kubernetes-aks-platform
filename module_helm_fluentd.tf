module "helm_fluentd" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-fluentd.git"

  chart_version = "0.0.2"
  dependencies = [
    "${module.namespace_monitoring.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace       = "monitoring"
  helm_repository      = "statcan"

  values = <<EOF
image:
  pullSecret: registry
  repository: statcan/kube-fluentd-operator

rbac:
  create: yes
EOF
}
