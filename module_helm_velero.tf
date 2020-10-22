module "helm_velero" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-velero.git?ref=v2.0.0"

  chart_version = "0.1.0"
  dependencies = [
    "${module.namespace_velero.depended_on}",
  ]

  helm_namespace  = "velero"
  helm_repository = "statcan"

  backup_storage_resource_group = "${var.velero_backup_storage_resource_group}"
  backup_storage_account        = "${var.velero_backup_storage_account}"
  backup_storage_bucket         = "${var.velero_backup_storage_bucket}"

  azure_client_id       = "${var.velero_azure_client_id}"
  azure_client_secret   = "${var.velero_azure_client_secret}"
  azure_resource_group  = "${var.velero_azure_resource_group}"
  azure_subscription_id = "${var.velero_azure_subscription_id}"
  azure_tenant_id       = "${var.velero_azure_tenant_id}"

  values = <<EOF
velero:
  image:
    repository: velero/velero
    tag: v1.3.1
    digest: sha256:0c74f1d552ef25a4227e582f4c0e6b3db3402abe196595ee9442ceeb43b99696
    pullPolicy: IfNotPresent
  initContainers:
    - name: velero-plugin-for-azure
      image: velero/velero-plugin-for-microsoft-azure:v1.0.1
      imagePullPolicy: IfNotPresent
      volumeMounts:
        - mountPath: /target
          name: plugins
  configuration:
    # Cloud provider being used (e.g. aws, azure, gcp).
    provider: azure
    # Parameters for the `default` BackupStorageLocation. See
    # https://velero.io/docs/v1.0.0/api-types/backupstoragelocation/
    backupStorageLocation:
      name: default
    # Parameters for the `default` VolumeSnapshotLocation. See
    # https://velero.io/docs/v1.0.0/api-types/volumesnapshotlocation/
    volumeSnapshotLocation:
      # Cloud provider where volume snapshots are being taken. Usually
      # should match `configuration.provider`. Required.,
      name: default
      # config:
      #  resourceGroup: k8s-XXXXX
  # Backup schedules to create.
  # Eg:
  # schedules:
  #   mybackup:
  #     schedule: "0 0 * * *"
  #     template:
  #       ttl: "240h"
  #       includedNamespaces:
  #        - foo
  schedules: {}
EOF
}
