ui = true
listener "tcp" {
  tls_disable = 1
  address = "[::]:8200"
  cluster_address = "[::]:8201"
}
storage "file" {
  path = "/vault/data"
}

seal "transit" {
  address = "http://vault-master.vault-master.svc:8200"
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "vault-child/"
  tls_skip_verify = "true"

  # env VULT_TOKEN
  # token = ""
}