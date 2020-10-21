module "helm_prometheus_operator" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-prometheus.git?ref=v2.0.0"

  chart_version = "0.0.2"
  dependencies = [
    "${module.namespace_monitoring.depended_on}",
    "${module.istio_operator.depended_on}",
  ]

  helm_namespace  = "${module.namespace_monitoring.name}"
  helm_repository = "statcan"

  values = <<EOF
# Default values for prometheus-operator.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

prometheus-operator:
  grafana:
    adminPassword: ${var.prometheus_grafana_password}

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
