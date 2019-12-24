variable "docker_repo" {
  description = "A repository url used as part of the image pull secret"
  default     = ""
}

variable "docker_username" {
  description = "A username used as part of the image pull secret"
  default     = ""
}

variable "docker_password" {
  description = "A password used as part of the image pull secret"
  default     = ""
}

variable "docker_email" {
  description = "A email used as part of the image pull secret"
  default     = ""
}

variable "docker_auth" {
  description = "A authorization code used as part of the image pull secret"
  default     = ""
}

variable "ingress_domain" {
  description = "The domain used for the majority of the platform services."
  default     = ""
}

variable "kubernetes_client_id" {
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
  default     = ""
}

variable "kubernetes_client_secret" {
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
  default     = ""
}

variable "kubernetes_rbac_group" {
  description = "A Kubernetes RBAC Group binding to use for this Managed Kubernetes Cluster"
  default     = ""
}

variable "enable_kubernetes_secret" {
  description = "The Secret to use for the image pull secret for this Managed Kubernetes Cluster"
  default     = ""
}

variable "kubernetes_secret" {
  description = "The Secret to use for the image pull secret for this Managed Kubernetes Cluster"
  default     = ""
}

variable "cert_manager_letsencrypt_email" {
  description = "The lets encrypt email to use for Cert Manager"
}

variable "cert_manager_azure_service_principal_id" {
  description = "The service principal to use for Cert Manager"
}

variable "cert_manager_azure_client_secret" {
  description = "The client secret of s.p. to use for Cert Manager"
}

variable "cert_manager_azure_subscription_id" {
  description = "The subscription id to use for Cert Manager"
}

variable "cert_manager_azure_tenant_id" {
  description = "The tenant id to use for Cert Manager"
}

variable "cert_manager_azure_resource_group_name" {
  description = "The resource group name to use for Cert Manager"
}

variable "cert_manager_azure_zone_name" {
  description = "The lets encrypt email to use for Cert Manager"
}

variable "velero_backup_storage_account" {
  description = "The storage account to use for the storage of cluster state"
}

variable "velero_backup_storage_bucket" {
  description = "The storage bucket to use for the storage of cluster state"
}

variable "velero_backup_storage_resource_group" {
  description = "The resource group to use for the storage of cluster state"
}

variable "velero_azure_client_id" {
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "velero_azure_client_secret" {
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
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

variable "vault_azure_sa_name" {
  description = "The storage account name used for vault"
}

variable "vault_azure_sa_key" {
  description = "The storage account key used for vault"
}

variable "vault_azure_sa_container" {
  description = "The storage account container name used for vault"
}

variable "vault_azure_kv_tenant_id" {
  description = "The vault service principal tenant id"
}

variable "vault_azure_kv_client_id" {
  description = "The vault service principal client id"
}

variable "vault_azure_kv_client_secret" {
  description = "The vault service principal client secret"
}

variable "vault_azure_kv_vault_name" {
  description = "The vault key vault name"
}

variable "vault_azure_kv_key_name" {
  description = "The vault key vault key"
}

variable "vault_aad_resource_id" {
  description = "Vault AAD Resource ID"
}

variable "vault_aad_client_id" {
  description = "Vault AAD Client ID"
}

variable "enable_azurefile" {
  description = "Enable adding a storage class that supports Azure File"
  default     = ""
}

variable "azurefile_location_name" {
  description = "The location (region) of the storage account to be used for the Storage Class"
}

variable "azurefile_storage_account_name" {
  description = "The storage account named to be used for the Storage Class"
}
