# Operators

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

data "helm_repository" "statcan" {
  name = "statcan"
  url  = "https://statcan.github.io/charts"
}

data "helm_repository" "aad_pod_identity" {
  name = "aad-pod-identity"
  url  = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
}

resource "null_resource" "helm_repo_add" {
  triggers = {
    run_everytime = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "helm repo add stable https://kubernetes-charts.storage.googleapis.com"
  }

  provisioner "local-exec" {
    command = "helm repo add jetstack https://charts.jetstack.io"
  }

  provisioner "local-exec" {
    command = "helm repo add istio https://storage.googleapis.com/istio-release/releases/1.4.9/charts"
  }

  provisioner "local-exec" {
    command = "helm repo add statcan https://statcan.github.io/charts"
  }

  provisioner "local-exec" {
    command = "helm repo add aad-pod-identity https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  }
}
