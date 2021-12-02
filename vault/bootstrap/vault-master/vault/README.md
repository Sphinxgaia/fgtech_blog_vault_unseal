<!-- BEGIN_TF_DOCS -->
# Article Fgtech Blog - 2021-11-30

Configuration de votre environnement Vault

## Configuration de la partie Vault AWS KMS - optionnel

Pour déployer la partie AWS KMS, exportez vos clés de connexion à l'API Amazon ayant des droits de création:
- aws\_kms\_key
- aws\_iam\_user
- aws\_iam\_access\_key

```bash
export AWS_ACCESS_KEY_ID=my_key
export AWS_SECRET_ACCESS_KEY=my_secret
```

Configurez le nom de votre cluster

```bash
export TF_VAR_cluster="k3d-podtato"
```

Déployer le vault AWS KMS

```bash
export TF_VAR_aws=true
```

## Lancement de votre application

```bash
terraform init
terraform apply -auto-approve # don't do that in production
```

## Initialisation

Démarrer une connexion via un tunnel sur votre poste

```bash
kubectl port-forward -n vault-master svc/vault-master 8200:8200
```

Ouvrez un navigateur si vous le souhaitez : [Vault UI](http://localhost:8100)

### Avec AWS KMS

Initialisation de votre Vault. Nous partons du principe que vous avez jq d'installer sur votre machine.

```bash
curl -s --request POST --data '{"recovery_shares": 3, "recovery_threshold": 2}' http://localhost:8200/v1/sys/init | jq
```

```console
{
  "keys": [],
  "keys_base64": [],
  "recovery_keys": [
    "090d368000d2b0af8269f4402842941b02a4df8f91a848fc2aaacc74fd9b9e26d1",
    "62f33b1c463a924a6be56b3264ac9de00dfd3ffc01827d5f29311049987c7f7b69",
    "2c865d8514d48ac2b441a1e3c7e43f600996421ccf09cf857a3f7d68e39633d44e"
  ],
  "recovery_keys_base64": [
    "CQ02gADSsK+CafRAKEKUGwKk34+RqEj8KqrMdP2bnibR",
    "YvM7HEY6kkpr5WsyZKyd4A39P/wBgn1fKTEQSZh8f3tp",
    "LIZdhRTUisK0QaHjx+Q/YAmWQhzPCc+Fej99aOOWM9RO"
  ],
  "root_token": "s.81hSWi1nwP3lrduZFv6zRare"
}
```

### Sans AWS KMS

Initialisation de votre Vault. Nous partons du principe que vous avez jq d'installer sur votre machine.

```bash
curl -s --request POST --data '{"secret_shares": 3, "secret_threshold": 2}' http://localhost:8200/v1/sys/init | jq
```

```console
{
  "keys": [
    "7e2820bfd0fd6e633407b47d49fc4a2e465e56348eb603e6493f42a925508301ff",
    "001ece3772eb8ba7a3ce37d703fc5c96bdfdf9fbcb700e9c0021f38d697167e2e9",
    "a856bdcc182a154585c9215412fc9d2d0b6276f4ce63ebcd150954fd700d0c7428"
  ],
  "keys_base64": [
    "figgv9D9bmM0B7R9SfxKLkZeVjSOtgPmST9CqSVQgwH/",
    "AB7ON3Lri6ejzjfXA/xclr39+fvLcA6cACHzjWlxZ+Lp",
    "qFa9zBgqFUWFySFUEvydLQtidvTOY+vNFQlU/XANDHQo"
  ],
  "root_token": "s.I5PYQZo5GSblQNv4JXjuAp5X"
}
```

> Si vous n'avez pas utiliser l'auto-unseal, vous devez déverrouiller votre Vault

```bash
export ROOT_TOKEN=s.I5PYQZo5GSblQNv4JXjuAp5X

curl -s --request POST --data '{"key": "7e2820bfd0fd6e633407b47d49fc4a2e465e56348eb603e6493f42a925508301ff"}' http://localhost:8200/v1/sys/unseal | jq

curl -s --request POST --data '{"key": "001ece3772eb8ba7a3ce37d703fc5c96bdfdf9fbcb700e9c0021f38d697167e2e9"}' http://localhost:8200/v1/sys/unseal | jq

```

## Retournons à la racine

[Racine](../../)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.4.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.4.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.6.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_kms"></a> [aws\_kms](#module\_aws\_kms) | ../kms | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.vault](https://registry.terraform.io/providers/hashicorp/helm/2.4.1/docs/resources/release) | resource |
| [kubernetes_namespace.vault](https://registry.terraform.io/providers/hashicorp/kubernetes/2.6.1/docs/resources/namespace) | resource |
| [kubernetes_secret.vault](https://registry.terraform.io/providers/hashicorp/kubernetes/2.6.1/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws"></a> [aws](#input\_aws) | Déploiement de la partie AWS KMS | `bool` | `false` | no |
| <a name="input_aws_kms_config"></a> [aws\_kms\_config](#input\_aws\_kms\_config) | Extra configuration for AWS KMS | `string` | n/a | yes |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | cluster Kuberntes cible | `string` | n/a | yes |
| <a name="input_namespace_prefix"></a> [namespace\_prefix](#input\_namespace\_prefix) | Prefix de l'ensemble de vos namespadces Vault | `string` | `"vault"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->