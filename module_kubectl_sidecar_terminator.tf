module "kubectl_sidecar_terminator" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-sidecar-terminator.git?ref=v1.0.0"

  dependencies = [
    module.namespace_istio_system.depended_on,
  ]

  kubectl_service_account = ""
  kubectl_namespace       = "kube-system"
}
