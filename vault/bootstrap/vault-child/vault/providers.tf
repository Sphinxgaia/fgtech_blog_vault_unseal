###################################################
# Providers                                       #
###################################################

provider "helm" {
  # Configuration options
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.cluster
}


provider "vault" {
  address    = var.vault_addr
}