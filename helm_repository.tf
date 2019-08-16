# Operators

data "helm_repository" "istio" {
    name = "istio"
    url  = "https://storage.googleapis.com/istio-release/releases/1.1.11/charts"
}

data "helm_repository" "stable" {
    name = "stable"
    url  = "https://kubernetes-charts.storage.googleapis.com"
}

data "helm_repository" "drupalwxt" {
    name = "drupalwxt"
    url  = "https://drupalwxt.github.io/helm-drupal"
}

data "helm_repository" "statcan" {
    name = "statcan"
    url  = "https://statcan.github.io/charts"
}

resource "null_resource" "helm_repo_add" {
  triggers = {
    run_everytime = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "helm repo add istio https://storage.googleapis.com/istio-release/releases/1.1.11/charts"
  }

  provisioner "local-exec" {
    command = "helm repo add jetstack https://charts.jetstack.io"
  }

  provisioner "local-exec" {
    command = "helm repo add stable https://kubernetes-charts.storage.googleapis.com"
  }

  provisioner "local-exec" {
    command = "helm repo add drupalwxt https://drupalwxt.github.io/helm-drupal"
  }

  provisioner "local-exec" {
    command = "helm repo add statcan https://statcan.github.io/charts"
  }
}