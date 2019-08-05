terraform {
  backend "azurerm" {
    storage_account_name  = "terraformkubernetes"
    container_name        = "k8s-tfstate"
    key                   = "aks-platform-development.terraform.tfstate"
  }
}

module "namespace_default" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "default"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# CI

resource "kubernetes_namespace" "ci" {
  metadata {
    name = "ci"

    labels = {
      istio-injection = "enabled"
    }
  }
}

module "namespace_ci" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.ci.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# Drupal

resource "kubernetes_namespace" "drupal" {
  metadata {
    name = "drupal"

    labels = {
      istio-injection = "enabled"
    }
  }
}

module "namespace_drupal" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.drupal.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # ServiceQuota Overrides
  allowed_loadbalancers = "10"
  allowed_nodeports = "10"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# ElasticSearch

resource "kubernetes_namespace" "elastic_system" {
  metadata {
    name = "elastic-system"

    labels = { }
  }
}

module "namespace_elastic_system" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.elastic_system.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# GateKeeper System

resource "kubernetes_namespace" "gatekeeper_system" {
  metadata {
    name = "gatekeeper-system"

    labels = {
      control-plane = "gatekeeper-system",
      istio-injection = "enabled"
    }
  }
}

module "namespace_gatekeeper_system" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.gatekeeper_system.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# Velero

resource "kubernetes_namespace" "velero" {
  metadata {
    name = "velero"
  }
}

module "namespace_velero" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.velero.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# Istio System

resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"

    labels = {
      control-plane = "istio-system"
    }
  }
}

module "namespace_istio_system" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.istio_system.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # ServiceQuota Overrides
  allowed_loadbalancers = "1"
  allowed_nodeports = "9"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

# KUBE-SYSTEM

resource "null_resource" "kube_system" {

  provisioner "local-exec" {
    command = "kubectl label ns kube-system control-plane=kube-system --overwrite"
  }
}

# Monitoring

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"

    labels = {
      control-plane = "monitoring"
    }
  }
}

module "namespace_monitoring" {
  source = "git::https://github.com/statcan/terraform-kubernetes-namespace.git"

  name = "${kubernetes_namespace.monitoring.metadata.0.name}"
  namespace_admins = {
    users = []
    groups = [
      "${var.kubernetes_rbac_group}"
    ]
  }

  # ServiceAccount
  helm_service_account = "tiller"

  # CICD
  ci_name = "argo"

  # Image Pull Secret
  # kubernetes_secret = "${var.kubernetes_secret}"
  # docker_repo = "${var.docker_repo}"
  # docker_username = "${var.docker_username}"
  # docker_password = "${var.docker_password}"
  # docker_email = "${var.docker_email}"
  # docker_auth = "${var.docker_auth}"

  dependencies = []
}

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
      "networking.k8s.io",
      "networking.istio.io",
      "authentication.istio.io",
      "config.istio.io",
      "monitoring.coreos.com"
    ]
    resources = ["*"]
    verbs = ["*"]
  }
}

# Operators

data "helm_repository" "istio" {
    name = "istio"
    url  = "https://storage.googleapis.com/istio-release/releases/1.1.11/charts"
}

data "helm_repository" "stable" {
    name = "stable"
    url  = "https://kubernetes-charts.storage.googleapis.com"
}

data "helm_repository" "drupalwxt" {
    name = "drupalwxt"
    url  = "https://drupalwxt.github.io/helm-drupal"
}

data "helm_repository" "statcan" {
    name = "statcan"
    url  = "https://statcan.github.io/charts"
}

resource "null_resource" "helm_repo_add" {
  triggers = {
    run_everytime = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "helm repo add istio https://storage.googleapis.com/istio-release/releases/1.1.11/charts"
  }

  provisioner "local-exec" {
    command = "helm repo add stable https://kubernetes-charts.storage.googleapis.com"
  }

  provisioner "local-exec" {
    command = "helm repo add drupalwxt https://drupalwxt.github.io/helm-drupal"
  }

  provisioner "local-exec" {
    command = "helm repo add statcan https://statcan.github.io/charts"
  }
}

module "kubectl_eck" {
  source = "git::https://github.com/statcan/terraform-kubernetes-elastic-cloud.git"

  dependencies = [
    "${module.namespace_elastic_system.depended_on}",
  ]

  kubectl_service_account = "${module.namespace_elastic_system.helm_service_account}"
  kubectl_namespace = "${module.namespace_elastic_system.name}"
}

module "helm_fluentd" {
  source = "git::https://github.com/statcan/terraform-kubernetes-fluentd.git"

  chart_version = "0.0.2"
  dependencies = [
    "${module.namespace_monitoring.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "monitoring"
  helm_repository = "statcan"

  values = <<EOF
image:
  pullSecret: registry

rbac:
  create: yes
EOF
}

module "helm_istio" {
  source = "git::https://github.com/statcan/terraform-kubernetes-istio.git"

  chart_version = "1.1.11"
  dependencies = [
    "${module.namespace_istio_system.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "istio-system"
  helm_repository = "istio"

  values = <<EOF
# Use a specific image
global:
  # tag: release-1.1-latest-daily

  k8sIngress:
    enabled: true
    enableHttps: true

  controlPlanSecurityEnabled: true
  disablePolicyChecks: false
  policyCheckFailOpen: false
  enableTracing: false

  mtls:
    enabled: true

  outboundTrafficPolicy:
    mode: ALLOW_ANY

sidecarInjectorWebhook:
  enabled: true
  # If true, webhook or istioctl injector will rewrite PodSpec for liveness
  # health check to redirect request to sidecar. This makes liveness check work
  # even when mTLS is enabled.
  rewriteAppHTTPProbe: true

gateways:
  istio-ingressgateway:
    sds:
      enabled: true
    serviceAnnotations:
      service.beta.kubernetes.io/azure-load-balancer-internal: 'true'

kiali:
  enabled: true
  contextPath: /
  ingress:
    enabled: true
    ## Used to create an Ingress record.
    hosts:
      - istio-kiali.${var.ingress_domain}
    annotations:
      # kubernetes.io/ingress.class: nginx
      # kubernetes.io/tls-acme: "true"
      kubernetes.io/ingress.class: "istio"
    tls:
      # Secrets must be manually created in the namespace.
      # - secretName: kiali-tls
      #   hosts:
      #     - kiali.local

  dashboard:
    grafanaURL: https://istio-grafana.${var.ingress_domain}

grafana:
  enabled: true
  contextPath: /
  ingress:
    enabled: true
    ## Used to create an Ingress record.
    hosts:
      - istio-grafana.${var.ingress_domain}
    annotations:
      # kubernetes.io/ingress.class: nginx
      # kubernetes.io/tls-acme: "true"
      kubernetes.io/ingress.class: "istio"
    tls:
      # Secrets must be manually created in the namespace.
      # - secretName: grafana-tls
      #   hosts:
      #     - grafana.local

prometheus:
  enabled: true
EOF
}

module "helm_prometheus_operator" {
  source = "git::https://github.com/statcan/terraform-kubernetes-prometheus.git"

  chart_version = "0.0.2"
  dependencies = [
    "${module.namespace_monitoring.depended_on}",
    "${module.helm_istio.depended_on}",
  ]

  helm_service_account = "${module.namespace_monitoring.helm_service_account}"
  helm_namespace = "${module.namespace_monitoring.name}"
  helm_repository = "statcan"

  values = <<EOF
prometheus-operator:
  grafana:
    adminPassword: promOperator

    ingress:
      enabled: true
      hosts:
        - grafana.${var.ingress_domain}
      path: /.*
      annotations:
        kubernetes.io/ingress.class: istio

    grafana.ini:
      auth.ldap:
        enabled: false

    persistence:
      enabled: true
      storageClassName: default
      accessModes: ["ReadWriteOnce"]
      size: 20Gi

  prometheus:
    ingress:
      enabled: true
      hosts:
        - prometheus.${var.ingress_domain}
      path: /.*
      annotations:
        kubernetes.io/ingress.class: istio

    prometheusSpec:
      storageSpec:
        volumeClaimTemplate:
          spec:
            accessModes: ["ReadWriteOnce"]
            storageClassName: default
            resources:
              requests:
                storage: 20Gi

  alertmanager:
    ingress:
      enabled: true
      hosts:
        - alertmanager.${var.ingress_domain}
      path: /.*
      annotations:
        kubernetes.io/ingress.class: istio

    alertmanagerSpec:
      storage:
        volumeClaimTemplate:
          spec:
            accessModes: ["ReadWriteOnce"]
            storageClassName: default
            resources:
              requests:
                storage: 20Gi

destinationRule:
  enabled: true
EOF
}

module "helm_velero" {
  source = "git::https://github.com/statcan/terraform-kubernetes-velero.git"

  chart_version = "0.0.2"
  dependencies = [
    "${module.namespace_velero.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "velero"
  helm_repository = "statcan"

  backup_storage_resource_group = "${var.velero_backup_storage_resource_group}"
  backup_storage_account = "${var.velero_backup_storage_account}"
  backup_storage_bucket = "${var.velero_backup_storage_bucket}"

  azure_client_id = "${var.velero_azure_client_id}"
  azure_client_secret = "${var.velero_azure_client_secret}"
  azure_resource_group = "${var.velero_azure_resource_group}"
  azure_subscription_id = "${var.velero_azure_subscription_id}"
  azure_tenant_id = "${var.velero_azure_tenant_id}"

  values = <<EOF
velero:
  image:
    repository: gcr.io/heptio-images/velero
    tag: v0.11.0
    pullPolicy: IfNotPresent

  configuration:
    backupStorageLocation:
      name: azure
EOF
}

# module "helm_drupalwxt" {
#   source = "git::https://github.com/drupalwxt/terraform-kubernetes-drupalwxt.git"

#   chart_version = "0.1.0"
#   dependencies = [
#     "${module.namespace_default.depended_on}",
#   ]

#   helm_service_account = "tiller"
#   helm_namespace = "default"
#   helm_repository = "drupalwxt"

#   values = <<EOF
# drupal:
#   tag: latest

#   # php-fpm healthcheck
#   # Requires https://github.com/renatomefi/php-fpm-healthcheck in the container.
#   # (note: official images do not contain this feature yet)
#   healthcheck:
#     enabled: true

#   # Switch to canada.ca theme
#   # Common options include: theme-wet-boew, theme-gcweb-legacy
#   wxtTheme: theme-gcweb

#   # Run the site install
#   install: true

#   # Run the default migrations
#   migrate: true

#   # Reconfigure the site
#   reconfigure: true

# nginx:
#   # Set your cluster's DNS resolution service here
#   resolver: 10.0.0.10

# mysql:
#   imageTag: 5.7.26

#   mysqlPassword: SUPERsecureMYSQLpassword
#   mysqlRootPassword: SUPERsecureMYSQLrootPASSWORD
#   persistence:
#     enabled: true

# ##
# ## MINIO-ONLY EXAMPLE
# ##
# minio:
#   persistence:
#     enabled: true
#   defaultBucket:
#     enabled: true

# ##
# ## AZURE EXAMPLE
# ##
# # files:
# #   cname:
# #     enabled: true
# #     hostname: wxt.blob.core.windows.net

# # minio:
# #   clusterDomain: cluster.cumulonimbus.zacharyseguin.ca
# #   # Enable the Azure Gateway mode
# #   azuregateway:
# #     enabled: true

# #   # Access Key should be set to the Azure Storage Account name
# #   # Secret Key should be set to the Azure Storage Account access key
# #   accessKey: STORAGE_ACCOUNT_NAME
# #   secretKey: STORAGE_ACCOUNT_ACCESS_KEY

# #   # Disable creation of default bucket.
# #   # You should pre-create the bucket in Azure.
# #   defaultBucket:
# #     enabled: false
# #     name: wxt

# #   # We want a cluster ip assigned
# #   service:
# #     clusterIP: ''

# #   # We don't need a persistent volume, since it's stored in Azure
# #   persistence:
# #     enabled: false
# EOF
# }

module "kubectl_opa" {
  source = "git::https://github.com/statcan/terraform-kubernetes-open-policy-agent.git"

  dependencies = [
    "${module.namespace_gatekeeper_system.depended_on}",
  ]

  kubectl_service_account = "${module.namespace_gatekeeper_system.helm_service_account}"
  kubectl_namespace = "${module.namespace_gatekeeper_system.name}"
}

# Permissions

resource "kubernetes_cluster_role_binding" "k8s" {
  metadata {
    name = "k8s-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind = "Group"
    name = "${var.kubernetes_rbac_group}"
  }
}

resource "kubernetes_cluster_role" "cluster-user" {
  metadata {
    name = "cluster-user"
  }

  # Read-only access to namespaces and nodes
  rule {
    api_groups = [""]
    resources = ["namespaces", "nodes"]
    verbs = ["list", "get", "watch"]
  }
}

# Namespace admin role
resource "kubernetes_role" "dashboard-user" {
  metadata {
    name = "dashboard-user"
    namespace = "kube-system"
  }

  # Read-only access to resource quotas
  rule {
    api_groups = [""]
    resources = ["services/proxy"]
    resource_names = ["https:kubernetes-dashboard:"]
    verbs = ["get", "create"]
  }
}
