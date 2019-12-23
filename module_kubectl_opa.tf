module "kubectl_opa" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git"

  dependencies = [
    "${module.namespace_gatekeeper_system.depended_on}",
  ]

  kubectl_service_account = "${module.namespace_gatekeeper_system.helm_service_account}"
  kubectl_namespace = "${module.namespace_gatekeeper_system.name}"
}
