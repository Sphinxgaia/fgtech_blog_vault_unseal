###################################################
# Variables                                       #
###################################################

variable "cluster" {
  type = string
  description = "cluster Kuberntes cible"
}

variable "namespace_prefix" {
  type = string
  description = "Prefix de l'ensemble de vos namespadces Vault"
  default = "vault"
}

variable "aws" {
  type = bool
  default = false
  description = "Déploiement de la partie AWS KMS"
}

variable "aws_kms_config" {
  type = string
  description = "Extra configuration for AWS KMS"
}