resource "kubernetes_service_account" "vault_auth" {
  metadata {
    name      = "vault-auth"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role_binding" "vault_auth_token_review" {
  metadata {
    name = "vault-auth"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.vault_auth.metadata.0.name
    namespace = kubernetes_service_account.vault_auth.metadata.0.namespace
  }
}
