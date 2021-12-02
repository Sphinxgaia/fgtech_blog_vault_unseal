###################################################
# Variables                                       #
###################################################

variable "cluster" {
  type = string
  description = "cluster Kuberntes cible"
}

variable "injector" {
  type = bool
  description= "Déploiement de l'injecteur Vault - agent k8s"
  default = false
}

variable "csi" {
  type = bool
  description= "Déploiement de l'injecteur Vault - agent k8s"
  default = false
}

variable "vault_addr" {
  type = string
  description = "Lien vers votre vault master"
}