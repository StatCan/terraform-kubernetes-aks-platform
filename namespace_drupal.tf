# Drupal

# resource "kubernetes_namespace" "drupal" {
#   metadata {
#     name = "drupal"

#     labels = {
#       istio-injection = "enabled"
#     }
#   }
# }

# module "namespace_drupal" {
#   source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

#   name = "${kubernetes_namespace.drupal.metadata.0.name}"
#   namespace_admins = {
#     users = []
#     groups = [
#       "${var.kubernetes_rbac_group}"
#     ]
#   }

#   # ServiceAccount
#   helm_service_account = "tiller"

#   # ServiceQuota Overrides
#   allowed_loadbalancers = "10"
#   allowed_nodeports = "10"

#   # CICD
#   ci_name = "argo"

#   # Image Pull Secret
#   # enable_kubernetes_secret = "${var.enable_kubernetes_secret}"
#   # kubernetes_secret = "${var.kubernetes_secret}"
#   # docker_repo = "${var.docker_repo}"
#   # docker_username = "${var.docker_username}"
#   # docker_password = "${var.docker_password}"
#   # docker_email = "${var.docker_email}"
#   # docker_auth = "${var.docker_auth}"

#   dependencies = []
# }
