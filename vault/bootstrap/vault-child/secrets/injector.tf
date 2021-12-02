###################################################
# Injector                                        #
###################################################

# Création d'un secret
# resource "vault_generic_secret" "version" {
#   path = "internal/data/podtato/version"
#   data_json = <<EOT
# {
#     "version": "captain"
# }
# EOT
# }

resource "vault_generic_secret" "secretinjector" {
  count = var.injector ? 1 : 0
  path = "internal/podtato"

  data_json = <<EOT
{
  "version":   "captain"
}
EOT
    depends_on = [
      vault_mount.kv
    ]
}


# Création d'une policy pour l'accès au role Kubernetes
resource "vault_policy" "podtato" {
  count = var.injector ? 1 : 0
  name = "prod-team"

  policy = <<EOT
path "internal/data/podtato" {
  capabilities = ["read"]
}
EOT
}

# Création du role Kubernetes pour l'utilisation
resource "vault_kubernetes_auth_backend_role" "podtato" {
  count = var.injector ? 1 : 0
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "podtato_vault"
  bound_service_account_names      = ["podtato"]
  bound_service_account_namespaces = ["podtato-kubectl-vault"]
  token_ttl                        = 3600
  token_policies                   = ["prod-team"]
}