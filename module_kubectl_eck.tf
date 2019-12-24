module "kubectl_eck" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-elastic-cloud.git"

  dependencies = [
    "${module.namespace_elastic_system.depended_on}",
  ]

  kubectl_service_account = "${module.namespace_elastic_system.helm_service_account}"
  kubectl_namespace       = "${module.namespace_elastic_system.name}"
}
