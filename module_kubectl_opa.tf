module "kubectl_opa" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git"

  dependencies = [
    "${module.namespace_gatekeeper_system.depended_on}",
  ]

  kubectl_service_account = "${module.namespace_gatekeeper_system.helm_service_account}"
  kubectl_namespace       = "${module.namespace_gatekeeper_system.name}"

  chart_version = "0.1.0"

  helm_service_account = "${module.namespace_gatekeeper_system.helm_service_account}"
  helm_namespace       = "${module.namespace_gatekeeper_system.name}"
  helm_repository      = "azure-policy"

  enable_azure_policy = 0
  values              = <<EOF

EOF

}
