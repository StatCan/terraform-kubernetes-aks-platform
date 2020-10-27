# Terraform for Azure Kubernetes Service Platform

The overall flow for this module is pretty simple:

* Create Azure storage account to store Terraform state
* Create Azure AKS Platform configuration in a modular manner
* Deploy the platform

If you would like to read more about our platform level components:

* [Azure AKS Platform](https://govcloud.blob.core.windows.net/docs/azure-aks-platform.pdf)

## Security Controls

We have recieved Authority to Operate and are happy to share our supporting documentation:

* Concept of Operations
* IT Security Controls (100+)
* CIS Benchmarks
* IBM Assessment

## Dependencies

* [terraform-kubernetes-aks](https://github.com/canada-ca-terraform-modules/terraform-kubernetes-aks)

## Optional (depending on options configured)

* None

## Workflow

1. Create terraform.tfvars based on example template provider.

> Note: You will need to add a client secret and grant admin consent to `k8s_velero_${prefix}` service principal in Azure AD.

> Note: You will need to add `k8s_velero_${prefix}` as role type `Contributor` to the Velero storage account

2. Ensure you have exported the `ARM_ACCESS_KEY` for the Terraform backend storage account.

```sh
export ARM_ACCESS_KEY=<secret>
```

3. Initialize and set the Terraform backend configuration parameters for the AzureRM provider.

```sh
terraform init\
    -backend-config="storage_account_name=terraform-$prefix" \
    -backend-config="container_name=k8s-tfstate" \
    -backend-config="key=$prefix-aks-platform.terraform.tfstate"
```

4. Create an execution plan and save the generated plan to a file.

```sh
terraform plan -out plan
```

5. Apply the changes required to reach desired state.

```sh
terraform apply plan
```

> Note: You might have to run terraform plan and apply a few times due to dependency issues.

## Usage

```terraform
# Secrets

enable_kubernetes_secret = "0"
kubernetes_secret        = ""
docker_repo              = ""
docker_username          = ""
docker_password          = ""
docker_email             = ""
docker_auth              = ""

# Cluster

kubernetes_rbac_group = ""
ingress_domain        = ""

# Cert Manager

cert_manager_letsencrypt_email          = ""
cert_manager_azure_service_principal_id = ""
cert_manager_azure_client_secret        = ""
cert_manager_azure_subscription_id      = ""
cert_manager_azure_tenant_id            = ""
cert_manager_azure_resource_group_name  = ""
cert_manager_azure_zone_name            = ""

# Prometheus
prometheus_grafana_password = ""

# Vault
vault_aad_client_id      = ""
vault_aad_resource_id    = "/subscriptions/<subscription>/resourceGroups/<resourcegroup>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<msi>"
vault_azure_storage_key  = ""
vault_azure_storage_name = ""
vault_keyvault_name      = ""
vault_tenant_id          = ""

# Velero
velero_backup_storage_resource_group = ""
velero_backup_storage_account        = ""
velero_backup_storage_bucket         = ""
velero_azure_client_id               = ""
velero_azure_client_secret           = ""
velero_azure_resource_group          = ""
velero_azure_subscription_id         = ""
velero_azure_tenant_id               = ""
```

## Variables Values

| Name                                    | Type   | Required | Value                                                                                  |
|-----------------------------------------|--------|----------|----------------------------------------------------------------------------------------|
| enable_kubernetes_secret                | string | yes      | The Secret to use for the image pull secret for this Managed Kubernetes Cluster        |
| kubernetes_secret                       | string | yes      | The Secret to use for the image pull secret for this Managed Kubernetes Cluster        |
| docker_repo                             | string | yes      | A repository url used as part of the image pull secret                                 |
| docker_username                         | string | yes      | A username used as part of the image pull secret                                       |
| docker_password                         | string | yes      | A password used as part of the image pull secret                                       |
| docker_email                            | string | yes      | A email used as part of the image pull secret                                          |
| docker_auth                             | string | yes      | A authorization code used as part of the image pull secret                             |
| ingress_domain                          | string | yes      | The domain used for the majority of the platform services                              |
| kubernetes_rbac_group                   | string | yes      | A Kubernetes RBAC Group binding to use for this Managed Kubernetes Cluster             |
| cert_manager_letsencrypt_email          | string | yes      | The lets encrypt email to use for Cert Manage                                          |
| cert_manager_azure_service_principal_id | string | yes      | The service principal to use for Cert Manager                                          |
| cert_manager_azure_client_secret        | string | yes      | The client secret of s.p. to use for Cert Manager                                      |
| cert_manager_azure_subscription_id      | string | yes      | The subscription id to use for Cert Manager                                            |
| cert_manager_azure_tenant_id            | string | yes      | The tenant id to use for Cert Manager                                                  |
| cert_manager_azure_resource_group_name  | string | yes      | The resource group name to use for Cert Manager                                        |
| cert_manager_azure_zone_name            | string | yes      | The lets encrypt email to use for Cert Manager                                         |
| prometheus_grafana_password             | string | yes      | Prometheus Operator password to access grafana                                         |
| vault_aad_resource_id                   | string | yes      | Vault AAD Resource ID                                                                  |
| vault_aad_client_id                     | string | yes      | Vault AAD Client ID                                                                    |
| vault_azure_storage_name                | string | yes      | The name assigned to Azure Storage Account used for storage                            |
| vault_azure_storage_key                 | string | yes      | The key to Azure Storage Account used for storage                                      |
| vault_keyvault_name                     | string | yes      | The KeyVault name where Vault resides                                                  |
| vault_tenant_id                         | string | yes      | The TenantId where Vault resides                                                       |
| velero_backup_storage_account           | string | yes      | The storage account to use for the storage of cluster state                            |
| velero_backup_storage_bucket            | string | yes      | The storage bucket to use for the storage of cluster state                             |
| velero_backup_storage_resource_group    | string | yes      | The resource group to use for the storage of cluster state                             |
| velero_azure_client_id                  | string | yes      | The Client ID for the Service Principal to use for this Managed Kubernetes Cluster     |
| velero_azure_client_secret              | string | yes      | The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster |
| velero_azure_resource_group             | string | yes      | The azure resource group to use for backing up cluster virtual machines/disks          |
| velero_azure_subscription_id            | string | yes      | The azure subscription id to use for backing up cluster virtual machines/disks         |
| velero_azure_tenant_id                  | string | yes      | The azure tenant id to use for backing up cluster virtual machines/disks               |

## History

| Date     | Release    | Change                                     |
|----------|------------|--------------------------------------------|
| 20200607 | 20200607.1 | Updates to the various Platform components |
| 20201026 | 20201026.1 | Updates to the various Platform components |
