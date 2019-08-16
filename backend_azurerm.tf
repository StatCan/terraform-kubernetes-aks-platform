terraform {
  backend "azurerm" {
    storage_account_name  = "terraformkubernetes"
    container_name        = "k8s-tfstate"
    key                   = "aks-platform-development.terraform.tfstate"
  }
}
