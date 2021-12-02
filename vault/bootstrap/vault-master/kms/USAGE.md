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