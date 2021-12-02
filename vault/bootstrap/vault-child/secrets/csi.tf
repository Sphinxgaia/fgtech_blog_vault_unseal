###################################################
# CSI                                             #
###################################################

resource "vault_generic_secret" "secretcsi" {
  count = var.csi ? 1 : 0
  path = "secret/podtato"

  data_json = <<EOT
{
  "version":   "v2"
}
EOT
    depends_on = [
    vault_mount.kvcsi
    ]
}

# Création d'une policy pour l'accès au role Kubernetes
resource "vault_policy" "podtato_csi" {
  count = var.csi ? 1 : 0
  name = "dev-team"

  policy = <<EOT
path "secret/data/podtato" {
  capabilities = ["read"]
}
EOT
}

# Création du role Kubernetes pour l'utilisation en mode CSI
resource "vault_kubernetes_auth_backend_role" "podtato_csi" {
  count = var.csi ? 1 : 0
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "podtato_csi"
  bound_service_account_names      = ["podtato"]
  bound_service_account_namespaces = ["podtato-kubectl-csi"]
  token_ttl                        = 3600
  token_policies                   = ["dev-team"]
  audience                         = "vault"
}