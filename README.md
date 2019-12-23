# Terraform for Azure Kubernetes Service Platform

The overall flow for this module is pretty simple:

* Create Azure storage account to store Terraform state
* Create Azure AKS Platform configuration in a modular manner
* Deploy the infrastructure incrementally

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* [terraform-kubernetes-aks](https://github.com/canada-ca-terraform-modules/terraform-kubernetes-aks)

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
    -backend-config="storage_account_name=terraformkubernetes" \
    -backend-config="container_name=k8s-tfstate" \
    -backend-config="key=${prefix}-aks-platform.terraform.tfstate"
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

## History

| Date     | Release    | Change      |
| -------- | ---------- | ----------- |
| 20190909 | 20190909.1 | 1st release |
