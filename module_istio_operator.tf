module "istio_operator" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-istio-operator.git?ref=v1.0.1"

  dependencies = [
    module.namespace_istio_operator.depended_on,
  ]

  # The following are variables that can be specified, but come with sane defaults
  namespace       = kubernetes_namespace.istio_operator.metadata.0.name
  istio_namespace = kubernetes_namespace.istio_system.metadata.0.name
  hub             = "docker.io/istio"
  tag             = "1.5.10"

  iop_spec = <<EOF
addonComponents:
  grafana:
    enabled: true
  kiali:
    enabled: true
  prometheus:
    enabled: true
components:
  cni:
    enabled: true
    namespace: kube-system
  ingressGateways:
    - enabled: true
      k8s:
        overlays:
          - apiVersion: networking.istio.io/v1beta1
            kind: Gateway
            name: ingressgateway
            patches:
              - path: metadata.name
                value: istio-autogenerated-k8s-ingress
              - path: 'spec.servers[0].tls'
                value:
                  httpsRedirect: true
              - path: 'spec.servers[0].port.protocol'
                value: HTTP2
              - path: 'spec.servers[1]'
                value:
                  hosts:
                    - '*'
                  port:
                    name: https-default
                    number: 443
                    protocol: HTTPS
                  tls:
                    credentialName: wildcard-tls
                    mode: SIMPLE
                    privateKey: sds
                    serverCertificate: sds
        serviceAnnotations:
          service.beta.kubernetes.io/azure-load-balancer-internal: 'false'
  policy:
    enabled: true
  telemetry:
    enabled: true
meshConfig:
  enableAutoMtls: true
profile: default
values:
  gateways:
    istio-ingressgateway:
      k8sIngress: false
      k8sIngressHttps: false
      sds:
        enabled: true
  global:
    controlPlaneSecurityEnabled: false
    disablePolicyChecks: false
    enableTracing: false
    k8sIngress:
      enableHttps: false
      enabled: false
    mtls:
      auto: true
      enabled: true
    outboundTrafficPolicy:
      mode: ALLOW_ANY
    sds:
      enabled: true
  grafana:
    contextPath: /
    enabled: true
    ingress:
      annotations:
        kubernetes.io/ingress.class: istio
      enabled: true
      hosts:
        - istio-grafana.${var.ingress_domain}
  kiali:
    contextPath: /
    dashboard:
      auth:
        strategy: login
      grafanaURL: https://istio-grafana.${var.ingress_domain}
      secretName: kiali
      viewOnlyMode: true
    enabled: true
    ingress:
      annotations:
        kubernetes.io/ingress.class: istio
      enabled: true
      hosts:
        - istio-kiali.${var.ingress_domain}
  pilot:
    enableProtocolSniffingForInbound: false
    enableProtocolSniffingForOutbound: false
  sidecarInjectorWebhook:
    rewriteAppHTTPProbe: true
EOF
}

resource "kubernetes_ingress" "istio_grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.istio_system.metadata.0.name

    annotations = {
      "kubernetes.io/ingress.class" = "istio"
    }
  }

  spec {
    rule {
      host = "istio-grafana.${var.ingress_domain}"
      http {
        path {
          # path = "/*"
          backend {
            service_name = "grafana"
            service_port = "3000"
          }
        }
      }
    }
  }
}

resource "kubernetes_secret" "kiali" {
  metadata {
    name      = "kiali"
    namespace = kubernetes_namespace.istio_system.metadata.0.name
  }

  data = {
    username   = "admin"
    passphrase = "admin"
  }

  type = "kubernetes.io/opaque"
}

resource "kubernetes_ingress" "istio_kiali" {
  metadata {
    name      = "kiali"
    namespace = kubernetes_namespace.istio_system.metadata.0.name

    annotations = {
      "kubernetes.io/ingress.class" = "istio"
    }
  }

  spec {
    rule {
      host = "istio-kiali.${var.ingress_domain}"
      http {
        path {
          # path = "/*"
          backend {
            service_name = "kiali"
            service_port = "20001"
          }
        }
      }
    }
  }
}
