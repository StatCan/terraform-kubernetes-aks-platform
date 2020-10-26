module "helm_fluentd" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-fluentd.git?ref=v2.0.1"

  chart_version = "0.3.3"
  dependencies = [
    module.namespace_monitoring.depended_on,
  ]

  helm_namespace  = "monitoring"
  helm_repository = "https://statcan.github.io/charts"
  # helm_repository_password = var.docker_password
  # helm_repository_username = var.docker_username

  values = <<EOF
image:
  pullSecret: registry
  repository: statcan/kube-fluentd-operator

rbac:
  create: yes
EOF
}
