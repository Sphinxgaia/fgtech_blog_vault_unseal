###################################################
# Outputs                                         #
###################################################

output "transit_token" {
  sensitive = true
  value = vault_token.transit.client_token
  description = "Token de connexion à l'autounseal"
}