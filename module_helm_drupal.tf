# module "helm_drupalwxt" {
#   source = "git::https://github.com/drupalwxt/terraform-kubernetes-drupalwxt.git"

#   chart_version = "0.2.2"
#   dependencies = [
#     "${module.namespace_drupal.depended_on}",
#   ]

#   helm_service_account = "tiller"
#   helm_namespace = "drupal"
#   helm_repository = "drupalwxt"

#   enable_azurefile = "${var.drupal_enable_azurefile}"
#   azurefile_location_name = "${var.drupal_azurefile_location_name}"
#   azurefile_storage_account_name = "${var.drupal_azurefile_storage_account_name}"

#   values = <<EOF
# ingress:
#   enabled: true
#   annotations:
#     # kubernetes.io/ingress.class: nginx
#     # kubernetes.io/tls-acme: "true"
#     kubernetes.io/ingress.class: istio
#   path: /*
#   hosts:
#     - drupalwxt.${var.ingress_domain}
#   tls: []
#   #  - secretName: chart-example-tls
#   #    hosts:
#   #      - chart-example.local

# drupal:
#   tag: 3.0.11

#   ## User of the application
#   ##
#   username: admin

#   ## Application password
#   ##
#   password: Password2019

#   # php-fpm healthcheck
#   # Requires https://github.com/renatomefi/php-fpm-healthcheck in the container.
#   # (note: official images do not contain this feature yet)
#   healthcheck:
#     enabled: true

#   # Switch to canada.ca theme
#   # Common options include: theme-wet-boew, theme-gcweb-legacy
#   wxtTheme: theme-gcweb

#   ## Extra settings.php settings
#   ##
#   extraSettings: ''
#   #  |-
#   #  $settings['trusted_host_patterns'] = ['^example\.com$'];

#   # Run the site install
#   install: true

#   # Run the default migrations
#   migrate: true

#   # Reconfigure the site
#   reconfigure: true

#   # Allows custom /var/www/html/sites/default/files and /var/www/private mounts
#   disableDefaultFilesMount: true

#   # kubectl create secret generic drupal-storage --from-literal=azurestorageaccountname=$STORAGE_ACCOUNT_NAME --from-literal=azurestorageaccountkey=$STORAGE_KEY -n drupal
#   volumes:
#     - name: files-public
#       azureFile:
#         secretName: drupal-storage
#         shareName: drupal-public
#     - name: files-private
#       azureFile:
#         secretName: drupal-storage
#         shareName: drupal-private

#   volumeMounts:
#     - name: files-public
#       mountPath: /var/www/html/sites/default/files
#     - name: files-private
#       mountPath: /var/www/private

# nginx:
#   tag: 3.0.11-nginx

#   # Set your cluster's DNS resolution service here
#   resolver: 10.0.0.10

#   # kubectl create secret generic drupal-storage --from-literal=azurestorageaccountname=$STORAGE_ACCOUNT_NAME --from-literal=azurestorageaccountkey=$STORAGE_KEY -n drupal
#   volumes:
#     - name: files-public
#       azureFile:
#         secretName: drupal-storage
#         shareName: drupal-public

#   volumeMounts:
#     - name: files-public
#       mountPath: /var/www/html/sites/default/files

# mysql:
#   imageTag: 5.7.28

#   mysqlPassword: SUPERsecureMYSQLpassword
#   mysqlRootPassword: SUPERsecureMYSQLrootPASSWORD
#   persistence:
#     enabled: true
#     storageClass: managed-premium
#     size: 256Gi

#   # Custom mysql configuration files used to override default mysql settings
#   configurationFiles:
#    mysql.cnf: |-
#      [mysqld]
#      max_allowed_packet = 256M
#      innodb_buffer_pool_size = 4096M
#      innodb_buffer_pool_instances = 4
#      table_definition_cache = 4096
#      table_open_cache = 8192
#      innodb_flush_log_at_trx_commit=2

# ##
# ## MINIO-ONLY EXAMPLE
# ##
# minio:
#   enabled: false

# ##
# ## AZURE EXAMPLE
# ##
# # files:
# #   cname:
# #     enabled: true
# #     hostname: wxt.blob.core.windows.net
# files:
#   provider: none

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
