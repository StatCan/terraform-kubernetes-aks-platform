# GateKeeper System

resource "kubernetes_namespace" "gatekeeper_system" {
  metadata {
    name = "gatekeeper-system"

    labels = {
      control-plane = "gatekeeper-system"
    }
  }
}

module "namespace_gatekeeper_system" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.gatekeeper_system.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

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
