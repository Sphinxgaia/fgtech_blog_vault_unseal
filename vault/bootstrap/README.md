# Article Fgtech Blog - 2021-11-30

Configuration de votre environnement Vault

## Configuration de la partie Vault AWS KMS - optionnel

Pour déployer la partie AWS KMS

```bash
export AWS_ACCESS_KEY_ID=my_key
export AWS_SECRET_ACCESS_KEY=my_secret
```

Configurez le nom de votre cluster

```bash
export TF_VAR_cluster="k3d-podtato"
```

Déployer le Vault avec AWS KMS

```bash
export TF_VAR_aws=true
```

Vous pouvez déployer globalement les éléments: 
[Vault MASTER](./bootstrap/vault-master)

[Vault Enfant](./bootstrap/vault-child)

