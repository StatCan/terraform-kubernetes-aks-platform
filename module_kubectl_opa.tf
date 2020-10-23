module "kubectl_opa" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git?ref=v2.0.0"

  dependencies = [
    module.namespace_gatekeeper_system.depended_on,
  ]

  kubectl_namespace = module.namespace_gatekeeper_system.name

  chart_version = "0.1.0"

  helm_namespace  = module.namespace_gatekeeper_system.name
  helm_repository = "https://raw.githubusercontent.com/Azure/azure-policy/master/extensions/policy-addon-kubernetes/helm-charts"

  enable_azure_policy = 0
  values              = <<EOF

EOF
}
