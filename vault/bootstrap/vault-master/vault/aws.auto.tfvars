aws_kms_config = <<EOF
seal "awskms" {
  region     = "eu-west-3"
  # env AWS_ACCESS_KEY_ID
  # access_key = ""
  
  # env AWS_SECRET_ACCESS_KEY
  # secret_key = ""
  
  # env AWS_SESSION_TOKEN
  # session_token = ""

  # env VAULT_AWSKMS_SEAL_KEY_ID
  # kms_key_id = ""

  # env AWS_KMS_ENDPOINT
  # endpoint   = ""
}
EOF
