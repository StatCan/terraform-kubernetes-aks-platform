module "kubectl_sidecar_terminator" {
  source = "git::https://github.com/statcan/terraform-kubernetes-sidecar-terminator.git"

  dependencies = [
    "${module.namespace_istio_system.depended_on}",
  ]

  kubectl_service_account = "tiller"
  kubectl_namespace = "kube-system"
}
