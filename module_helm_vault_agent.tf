module "helm_vault_agent" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-vault.git"

  chart_version = "0.0.7"
  dependencies = [
    "${module.namespace_vault.depended_on}",
    "${null_resource.helm_repo_add.id}",
  ]

  helm_release_name    = "vault-agent"
  helm_service_account = "tiller"
  helm_namespace       = "vault"
  helm_repository      = "statcan"

  values = <<EOF
vault:
  injector:
    enabled: true
    image:
      repository: "hashicorp/vault-k8s"
      tag: "0.3.0"

  server:
    standalone:
      enabled: false
    ha:
      enabled: false
    dev:
      enabled: false

destinationRule:
  enabled: false
EOF
}

# resource "null_resource" "vault_agent_patches" {
#   triggers = {
#     revision = "${module.helm_vault_agent.release_revision}"
#   }
#   provisioner "local-exec" {
#     command = "kubectl -n cloudops patch deployment vault-agent-agent-injector --type=json -p='[{\"op\": \"replace\", \"path\": \"/spec/template/metadata/annotations\", \"value\": { \"sidecar.istio.io/inject\": \"false\" }}]'"
#   }

#   provisioner "local-exec" {
#     command = "kubectl -n cloudops patch deployment vault-agent-agent-injector --type=json -p='[{\"op\": \"replace\", \"path\": \"/spec/template/spec/containers/0/env/2/value\", \"value\": \"https://vault.example.ca\"}]'"
#   }

#   provisioner "local-exec" {
#     command = "kubectl -n cloudops patch deployment vault-agent-agent-injector --type=json -p='[{\"op\": \"add\", \"path\": \"/spec/template/spec/containers/0/env/6\", \"value\": { \"name\": \"AGENT_INJECT_VAULT_AUTH_PATH\", \"value\": \"auth/k8s-cancentral-01-tc-aks\"}}]'"
#   }

#   depends_on = [
#     "module.helm_vault_agent"
#   ]
# }
