<!-- BEGIN_TF_DOCS -->
# Article Fgtech Blog - 2021-11-30

Configuration de votre environnement Vault

## Configuration de la partie Vault AWS KMS - optionnel

Pour déployer la partie AWS KMS unitairement

```bash
export AWS_ACCESS_KEY_ID=my_key
export AWS_SECRET_ACCESS_KEY=my_secret

terraform init
terraform apply -aut-autoapprove
```

Vous devrez récupérer manuellement ou programatiquement les infos de d'authentification ainsi que l'id de l'objet AWS KMS.

>Ces informations sont des outputs du module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.66.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.66.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.vault](https://registry.terraform.io/providers/hashicorp/aws/3.66.0/docs/resources/iam_access_key) | resource |
| [aws_iam_user.vault](https://registry.terraform.io/providers/hashicorp/aws/3.66.0/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.vault-kms-unseal](https://registry.terraform.io/providers/hashicorp/aws/3.66.0/docs/resources/iam_user_policy) | resource |
| [aws_kms_key.vault](https://registry.terraform.io/providers/hashicorp/aws/3.66.0/docs/resources/kms_key) | resource |
| [random_pet.env](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.vault-kms-unseal](https://registry.terraform.io/providers/hashicorp/aws/3.66.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Name of your Vault | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags List | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_creds"></a> [creds](#output\_creds) | iam connexion for auto unseal KMS |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | AWS KMS ID |
<!-- END_TF_DOCS -->