###################################################
# Variables                                       #
###################################################

variable "transit_path" {
  type = string
  description = "Point de montage pour votre transit key"
}

variable "create_mount" {
  type = bool
  description = "Création du point de montage de votre clé"
  default = false
}