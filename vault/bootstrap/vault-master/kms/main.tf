###################################################
# Main                                            #
###################################################

# Create AWS KMS                                  #
###################################################

# random Name
resource "random_pet" "env" {
  length    = 2
  separator = "_"
}

# KMS Key
resource "aws_kms_key" "vault" {
  description             = "KMS Unseal Key"
  deletion_window_in_days = 10

  # Production value
  # enable_key_rotation = true
  # multi_region = true

  tags = merge(
    { Name = "vault-kms-unseal-${local.suffix}"}, 
    var.tags 
    )
}


# User                                            #
###################################################

# AWS User
resource "aws_iam_user" "vault" {
  name = "vault-kms-unseal-${local.suffix}"

  tags = var.tags 
}

# Generate credential for vault user
resource "aws_iam_access_key" "vault" {
  user = aws_iam_user.vault.name
}

# User inline policy mapping
resource "aws_iam_user_policy" "vault-kms-unseal" {

  name =  "vault-kms-unseal"
  user   = aws_iam_user.vault.name
  policy = data.aws_iam_policy_document.vault-kms-unseal.json
}

