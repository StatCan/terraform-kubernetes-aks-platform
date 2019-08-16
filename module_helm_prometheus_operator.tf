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
