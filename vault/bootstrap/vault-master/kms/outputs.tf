###################################################
# Outputs                                         #
###################################################

output "creds" {
  sensitive = true
  value = aws_iam_access_key.vault
  description = "iam connexion for auto unseal KMS"
}

output "key_id" {
  sensitive = true
  value = aws_kms_key.vault.key_id
  description = "AWS KMS ID"
}