###################################################
# Locals                                          #
###################################################

locals {
  suffix = var.cluster == "" ? random_pet.env.id : var.cluster
}