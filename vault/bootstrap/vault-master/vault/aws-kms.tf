###################################################
# AWS KMS                                         #
###################################################

module "aws_kms" {
  count = var.aws ? 1 : 0

  source = "../kms"
 
}

resource "kubernetes_secret" "vault" {
  # déployer si var.aws == true
  count = var.aws ? 1 : 0
  metadata {
    name = "${var.namespace_prefix}-master"
    namespace = "${var.namespace_prefix}-master"
  }

  data = {
    "AWS_ACCESS_KEY_ID" = module.aws_kms[count.index].creds.id

    "AWS_SECRET_ACCESS_KEY" = module.aws_kms[count.index].creds.secret

    "VAULT_AWSKMS_SEAL_KEY_ID" = module.aws_kms[count.index].key_id
  }
}
