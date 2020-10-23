# Istio-Operator

resource "kubernetes_namespace" "istio_operator" {
  metadata {
    name = "istio-operator"

    labels = {
      istio-injection        = "disabled"
      istio-operator-managed = "Reconcile"
    }
  }
}

module "namespace_istio_operator" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-namespace.git?ref=v2.1.0"

  name = kubernetes_namespace.istio_operator.metadata.0.name
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceQuota Overrides
  allowed_loadbalancers = "1"
  allowed_nodeports     = "1"

  # CICD
  ci_name = "deploy"

  # Image Pull Secret
  enable_kubernetes_secret = var.enable_kubernetes_secret
  kubernetes_secret        = var.kubernetes_secret
  docker_repo              = var.docker_repo
  docker_username          = var.docker_username
  docker_password          = var.docker_password
  docker_email             = var.docker_email
  docker_auth              = var.docker_auth

  dependencies = []
}
