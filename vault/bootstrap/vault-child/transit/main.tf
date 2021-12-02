###################################################
# Main                                            #
###################################################


# only for our sample
resource "vault_mount" "transit" {
  count = var.create_mount ? 1 : 0
  path                      = var.transit_path
  type                      = "transit"
  description               = "transit Demo"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "key" {
  backend = var.transit_path
  name    = "autounseal"

  depends_on = [
    vault_mount.transit
  ]
}

resource "vault_policy" "transit" {
  name = "transit-${var.transit_path}"

  policy = <<EOT
path "${var.transit_path}/encrypt/autounseal" {
  capabilities = ["update"]
}

path "${var.transit_path}/decrypt/autounseal" {
  capabilities = ["update"]
}
EOT
}

resource "vault_token" "transit" {

  policies = ["transit-${var.transit_path}"]
  display_name = "transit-${var.transit_path}"
  renewable = true
  ttl = "24h" # be careful
 
  renew_min_lease = 43200
  renew_increment = 86400
}