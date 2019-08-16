# Istio System

resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"

    labels = {
      control-plane = "istio-system"
    }
  }
}

module "namespace_istio_system" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.istio_system.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # ServiceQuota Overrides
  allowed_loadbalancers = "1"
  allowed_nodeports = "9"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # enable_kubernetes_secret = "${var.enable_kubernetes_secret}"
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}