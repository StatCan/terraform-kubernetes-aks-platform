# Tiller role

resource "kubernetes_cluster_role" "tiller" {
  metadata {
    name = "tiller"
  }

  rule {
    api_groups = [
      "",
      "extensions",
      "apps",
      "batch",
      "policy",
      "admissionregistration.k8s.io",
      "rbac.authorization.k8s.io",
      "apiextensions.k8s.io",
      "apiregistration.k8s.io",
      "networking.k8s.io",
      "networking.istio.io",
      "authentication.istio.io",
      "config.istio.io",
      "monitoring.coreos.com",
      "certmanager.k8s.io"
    ]
    resources = ["*"]
    verbs     = ["*"]
  }
}

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
    name      = "${var.kubernetes_rbac_group}"
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

# Namespace admin role
resource "kubernetes_role" "dashboard-user" {
  metadata {
    name      = "dashboard-user"
    namespace = "kube-system"
  }

  # Read-only access to resource quotas
  rule {
    api_groups     = [""]
    resources      = ["services/proxy"]
    resource_names = ["https:kubernetes-dashboard:"]
    verbs          = ["get", "create"]
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
    namespace = "${kubernetes_namespace.ci.metadata.0.name}"
  }
}

# Allow kubecost to deploy to any namespace (ClusterAdmin)
resource "kubernetes_cluster_role_binding" "kubecost-cluster-admin" {
  metadata {
    name = "kubecost-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "${kubernetes_namespace.kubecost.metadata.0.name}"
  }
}
