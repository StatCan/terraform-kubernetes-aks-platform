module "helm_cert_manager" {
  source = "git::https://github.com/statcan/terraform-kubernetes-cert-manager.git"

  chart_version = "0.8.1"
  dependencies = [
    "${module.namespace_cert_manager.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "${kubernetes_namespace.cert_manager.metadata.0.name}"
  helm_repository = "jetstack"

  letsencrypt_email = "${var.cert_manager_letsencrypt_email}"
  azure_service_principal_id = "${var.cert_manager_azure_service_principal_id}"
  azure_client_secret = "${var.cert_manager_azure_client_secret}"
  azure_subscription_id = "${var.cert_manager_azure_subscription_id}"
  azure_tenant_id = "${var.cert_manager_azure_tenant_id}"
  azure_resource_group_name = "${var.cert_manager_azure_resource_group_name}"
  azure_zone_name = "${var.cert_manager_azure_zone_name}"

  values = <<EOF
podDnsConfig:
  nameservers:
    - 1.1.1.1
    - 1.0.0.1
    - 8.8.8.8
EOF
}

# Certificates

resource "local_file" "cert_wildcard" {
  content = "${templatefile("${path.module}/config/wildcard.yaml", {
    ingress_domain = "${var.ingress_domain}"
  })}"

  filename = "${path.module}/generated/wildcard.yaml"
}

resource "null_resource" "cert_wildcard" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.cert_wildcard.filename}"
  }

  depends_on = [
    "module.helm_cert_manager"
  ]
}
