# Permissions

resource "kubernetes_cluster_role_binding" "k8s" {
  metadata {
    name = "k8s-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = var.kubernetes_rbac_group
  }

}

resource "kubernetes_cluster_role" "cluster-user" {
  metadata {
    name = "cluster-user"
  }

  # Read-only access to namespaces and nodes
  rule {
    api_groups = [""]
    resources  = ["namespaces", "nodes"]
    verbs      = ["list", "get", "watch"]
  }
}

# Allow deploy to deploy to any namespace (ClusterAdmin)
resource "kubernetes_cluster_role_binding" "ci-deploy-cluster-admin" {
  metadata {
    name = "ci-deploy-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "deploy"
    namespace = kubernetes_namespace.ci.metadata.0.name
  }
}
