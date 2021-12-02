###################################################
# Main                                            #
###################################################


resource "kubernetes_namespace" "vault" {
  metadata {
    name = "${var.namespace_prefix}-child"
  }
}


resource "helm_release" "vault" {

  name       = "${var.namespace_prefix}-child"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.17.0"

  namespace = "${var.namespace_prefix}-child"

  set {
    name  = "injector.enabled"
    value = var.injector
  }

  set {
    name  = "csi.enabled"
    value = var.csi
  }

  set {
    name  = "server.standalone.config"
    value  = file("files/dev-config.hcl")

  }

  set {
    name  = "server.dataStorage.enabled"
    value  = true
  }

  set {
    name  = "server.dataStorage.size"
    value  = "1Gi"
  }

  # Dev Port
  set {
    name  = "server.service.port"
    value  = 8100
  }

  values = [ <<EOF
server:
  extraSecretEnvironmentVars:
    - envName: "VAULT_TOKEN"
      secretName: "${var.namespace_prefix}-child"
      secretKey: "VAULT_TOKEN"

EOF 

   ]

}
 

resource "helm_release" "csi_driver" {

  count = var.csi ? 1 : 0

  name       = "csi-secrets-store"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"

  namespace = "kube-system"

  set {
    name  = "syncSecret.enabled"
    value = true
  }
}