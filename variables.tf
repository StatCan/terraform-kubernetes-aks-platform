variable "docker_repo" {
  description = "A repository url used as part of the image pull secret"
}

variable "docker_username" {
  description = "A username used as part of the image pull secret"
}

variable "docker_password" {
  description = "A password used as part of the image pull secret"
}

variable "docker_email" {
  description = "A email used as part of the image pull secret"
}

variable "docker_auth" {
  description = "A authorization code used as part of the image pull secret"
}

variable "ingress_domain" {
  description = "The domain used for the majority of the platform services."
}

variable "velero_azure_tenant_id" {
  description = "The azure tenant id to use for backing up cluster virtual machines/disks"
}

variable "kubernetes_client_id" {
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "kubernetes_client_secret" {
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "kubernetes_rbac_group" {
  description = "A Kubernetes RBAC Group binding to use for this Managed Kubernetes Cluster"
}

variable "velero_storage_account" {
  description = "The storage account to use for the storage of cluster state"
}

variable "velero_storage_bucket" {
  description = "The storage bucket to use for the storage of cluster state"
}

variable "velero_storage_resource_group" {
  description = "The resource group to use for the storage of cluster state"
}

variable "velero_azure_resource_group" {
  description = "The azure resource group to use for backing up cluster virtual machines/disks"
}

variable "velero_azure_resource_group" {
  description = "The azure resource group to use for backing up cluster virtual machines/disks"
}

variable "velero_azure_subscription_id" {
  description = "The azure subscription id to use for backing up cluster virtual machines/disks"
}

variable "velero_azure_tenant_id" {
  description = "The azure tenant id to use for backing up cluster virtual machines/disks"
}
