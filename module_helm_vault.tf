# # AAD Pod Identity Configuration for Vault
# resource "local_file" "vault_aad" {
#   content = "${templatefile("${path.module}/config/vault/aad.yaml", {
#     vault_aad_resource_id = "${var.vault_aad_resource_id}"
#     vault_aad_client_id = "${var.vault_aad_client_id}"
#   })}"
#   filename = "${path.module}/generated/vault/aad.yaml"
# }

# resource "null_resource" "vault_aad" {
#   provisioner "local-exec" {
#     command = "kubectl apply -f ${local_file.vault_aad.filename}"
#   }
#   depends_on = [
#     "module.helm_cert_manager"
#   ]
# }

# module "helm_vault" {
#   source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-vault.git"

#   chart_version = "0.0.6"
#   dependencies = [
#     "${module.namespace_vault.depended_on}",
#   ]

#   helm_service_account = "tiller"
#   helm_namespace = "vault"
#   helm_repository = "statcan"

#   values = <<EOF
# vault:
#   server:
#     ingress:
#       enabled: true
#       hosts:
#         - host: vault.${var.ingress_domain}
#           paths:
#             - /.*
#       annotations:
#         kubernetes.io/ingress.class: istio

#     extraLabels:
#       aadpodidbinding: vault

#     standalone:
#       config: |
#         ui = true

#         listener "tcp" {
#           tls_disable = 1
#           address = "[::]:8200"
#           cluster_address = "[::]:8201"
#         }

#         storage "azure" {
#           accountName = "${var.vault_azure_sa_name}"
#           accountKey = "${var.vault_azure_sa_key}"
#           container = "${var.vault_azure_sa_container}"
#         }

#         seal "azurekeyvault" {
#           tenant_id        = "${var.vault_azure_kv_tenant_id}"
#           vault_name       = "${var.vault_azure_kv_vault_name}"
#           key_name         = "${var.vault_azure_kv_key_name}"
#         }

#   destinationRule:
#     enabled: false
# EOF
# }
