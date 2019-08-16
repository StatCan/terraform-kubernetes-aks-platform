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
