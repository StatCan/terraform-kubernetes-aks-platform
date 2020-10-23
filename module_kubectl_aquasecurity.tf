module "kubectl_aquasecurity" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-aquasecurity?ref=v1.0.0"

  dependencies = [
    module.namespace_starboard.depended_on,
  ]

  kubectl_namespace = module.namespace_starboard.name
}
