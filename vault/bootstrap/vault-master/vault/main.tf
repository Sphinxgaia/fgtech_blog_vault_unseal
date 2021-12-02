###################################################
# Main                                            #
###################################################

locals {
  config_hcl = var.aws ? join ("", [file("files/master-config.hcl"), var.aws_kms_config]) : file("files/master-config.hcl")
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = "${var.namespace_prefix}-master"
  }
}


resource "helm_release" "vault" {

  name       = "${var.namespace_prefix}-master"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.17.0"

  namespace = "${var.namespace_prefix}-master"

  set {
    name  = "injector.enabled"
    value = "false"
  }

  set {
    name  = "server.standalone.config"
    value  = local.config_hcl
  }

  set {
    name  = "server.dataStorage.enabled"
    value  = true
  }

  set {
    name  = "server.dataStorage.size"
    value  = "1Gi"
  }

  values = [ var.aws ? <<EOF
server:
  extraSecretEnvironmentVars:
    - envName: "AWS_ACCESS_KEY_ID"
      secretName: "${var.namespace_prefix}-master"
      secretKey: "AWS_ACCESS_KEY_ID"
    - envName: "AWS_SECRET_ACCESS_KEY"
      secretName: "${var.namespace_prefix}-master"
      secretKey: "AWS_SECRET_ACCESS_KEY"
    - envName: "VAULT_AWSKMS_SEAL_KEY_ID"
      secretName: "${var.namespace_prefix}-master"
      secretKey: "VAULT_AWSKMS_SEAL_KEY_ID"

EOF 
: ""

   ]

}
 