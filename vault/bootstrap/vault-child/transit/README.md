<!-- BEGIN_TF_DOCS -->
# Article Fgtech Blog - 2021-11-30

Configuration de votre environnement Vault

## Configuration de la partie Vault transit key

Ce module doit avoir un provider vault valide fourni par son parent

```bash
export VAULT_TOKEN="s.81hSWi1nwP3lrduZFv6zRare" # Pour le lab, utiliser le token root
export TF_VAR_vault_addr="http://localhost:8200" # dans notre exemple nous assumons que vous avez toujours votre portforward ouvert et que vous avez les droits de faire des actions sur le vault master
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_mount.transit](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/mount) | resource |
| [vault_policy.transit](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/policy) | resource |
| [vault_token.transit](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/token) | resource |
| [vault_transit_secret_backend_key.key](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/transit_secret_backend_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_mount"></a> [create\_mount](#input\_create\_mount) | Création du point de montage de votre clé | `bool` | `false` | no |
| <a name="input_transit_path"></a> [transit\_path](#input\_transit\_path) | Point de montage pour votre transit key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_transit_token"></a> [transit\_token](#output\_transit\_token) | Token de connexion à l'autounseal |
<!-- END_TF_DOCS -->