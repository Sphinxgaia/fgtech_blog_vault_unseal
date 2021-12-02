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


provider "aws" {
  region = "eu-west-3"
  
  # export env
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}