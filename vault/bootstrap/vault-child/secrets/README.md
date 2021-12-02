<!-- BEGIN_TF_DOCS -->
# Article Fgtech Blog - 2021-11-30

Configuration de votre environnement Vault

## Configuration de la partie Vault kubernetes

```bash
export VAULT_TOKEN="s.81hSWi1nwP3lrduZFv6zRare" # Pour le lab, utiliser le token root
export TF_VAR_vault_addr="http://localhost:8100" # dans notre exemple nous assumons que vous avez toujours votre portforward ouvert et que vous avez les droits de faire des actions sur le vault master
```

Créer les secrets pour les points de montage en fonction de l'injecteur choisi

```bash
export TF_VAR_injector=true
export TF_VAR_csi=true
```

Lancer l'installation

```bash
terraform init
terraform apply -auto-approve # don't do that in production
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_auth_backend.kubernetes](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/auth_backend) | resource |
| [vault_generic_secret.secretcsi](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/generic_secret) | resource |
| [vault_generic_secret.secretinjector](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/generic_secret) | resource |
| [vault_kubernetes_auth_backend_config.k3d-podtato](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/kubernetes_auth_backend_config) | resource |
| [vault_kubernetes_auth_backend_role.podtato](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_kubernetes_auth_backend_role.podtato_csi](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_mount.kv](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/mount) | resource |
| [vault_mount.kvcsi](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/mount) | resource |
| [vault_policy.podtato](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/policy) | resource |
| [vault_policy.podtato_csi](https://registry.terraform.io/providers/hashicorp/vault/3.0.1/docs/resources/policy) | resource |
| [kubernetes_secret.issuer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |
| [kubernetes_service_account.issuer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_csi"></a> [csi](#input\_csi) | Déploiement de l'injecteur Vault - agent k8s | `bool` | `false` | no |
| <a name="input_injector"></a> [injector](#input\_injector) | Déploiement de l'injecteur Vault - agent k8s | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->