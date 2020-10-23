# Cert Manager

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"

    annotations = {
      "logging.csp.vmware.com/fluentd-status" = ""
    }

    labels = {
      "certmanager.k8s.io/disable-validation" = "true"
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["logging.csp.vmware.com/fluentd-status"]
    ]
  }
}

module "namespace_cert_manager" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-namespace.git?ref=v2.1.0"

  name = kubernetes_namespace.cert_manager.metadata.0.name
  namespace_admins = {
    users = []
    groups = [
      var.kubernetes_rbac_group
    ]
  }

  # CICD
  ci_name = "deploy"

  # Image Pull Secret
  # enable_kubernetes_secret = var.enable_kubernetes_secret
  # kubernetes_secret = var.kubernetes_secret
  # docker_repo = var.docker_repo
  # docker_username = var.docker_username
  # docker_password = var.docker_password
  # docker_email = var.docker_email
  # docker_auth = var.docker_auth

  dependencies = []
}
