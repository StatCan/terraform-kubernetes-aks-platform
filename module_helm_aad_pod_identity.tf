module "helm_aad_pod_identity" {
  source        = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-aad-pod-identity.git"
  chart_version = "1.6.0"
  dependencies = [
    "${module.namespace_default.depended_on}",
  ]
  helm_service_account = "tiller"
  helm_namespace       = "default"
  helm_repository      = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  resource_id          = ""
  client_id            = ""
  values               = <<EOF
# Default values for pod-aad-identity-helm.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
forceNameSpaced: "true"
rbac:
  enabled: true
azureIdentity:
  enabled: false # enabled/disable deployment of azure identity and binding
EOF
}
