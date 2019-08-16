# Terraform for Azure Kubernetes Service Platform

The overall flow for this module is pretty simple:

* Create Azure storage account to store Terraform state
* Create Azure AKS Platform configuration in a modular manner
* Deploy the infrastructure incrementally

## Init

Ensure you have exported the ARM access key for storage account.

```sh
export ARM_ACCESS_KEY=<secret>
```

Set the backend config parameters for the AzureRM Terraform provider.

```sh
terraform init\
    -backend-config="storage_account_name=terraformkubernetes" \
    -backend-config="container_name=k8s-tfstate" \
    -backend-config="key=aks-platform-development.terraform.tfstate"
```

## Plan

```sh
terraform plan -out plan
```

## Apply

```sh
terraform apply plan
```
