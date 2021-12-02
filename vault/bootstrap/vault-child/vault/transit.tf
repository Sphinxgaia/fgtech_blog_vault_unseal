###################################################
# Transit Key                                     #
###################################################


module "transit" {

  source = "../transit"

  transit_path = "vault-child"
  create_mount = true
 
}

resource "kubernetes_secret" "vault" {
  metadata {
    name = "${var.namespace_prefix}-child"
    namespace = "${var.namespace_prefix}-child"
  }

  data = {
    "VAULT_TOKEN" = module.transit.transit_token
  }
}