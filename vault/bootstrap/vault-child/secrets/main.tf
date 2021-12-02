###################################################
# Main                                            #
###################################################


# only for our sample
resource "vault_mount" "kv" {
  count = var.injector ? 1 : 0
  path                      = "internal"
  type                      = "kv-v2"
  description               = "Injector KV"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}


# only for our sample
resource "vault_mount" "kvcsi" {
  count = var.csi ? 1 : 0
  path                      = "internal"
  type                      = "kv-v2"
  description               = "Injector KV"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}
