module "kubectl_eck" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-elastic-cloud.git?ref=v1.0.0"

  dependencies = [
    "${module.namespace_elastic_system.depended_on}",
  ]

  kubectl_service_account = ""
  kubectl_namespace       = "${module.namespace_elastic_system.name}"
}
