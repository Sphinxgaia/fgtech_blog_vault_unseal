###################################################
# Variables                                       #
###################################################

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags List"
}

variable "cluster" {
  type = string
  default = ""
  description = "Name of your Vault"
}