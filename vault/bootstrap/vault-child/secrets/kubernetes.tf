###################################################
# Kubernetes auth                                 #
###################################################

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

data "kubernetes_service_account" "issuer" {
  metadata {
    name = "vault-child"
    namespace  = "vault-child"
  }
}

data "kubernetes_secret" "issuer" {
  metadata {
    name = data.kubernetes_service_account.issuer.default_secret_name
    namespace = "vault-child"
  }
}

resource "vault_kubernetes_auth_backend_config" "k3d-podtato" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc"
#   kubernetes_ca_cert     = data.kubernetes_secret.issuer.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.issuer.data.token
  
}

