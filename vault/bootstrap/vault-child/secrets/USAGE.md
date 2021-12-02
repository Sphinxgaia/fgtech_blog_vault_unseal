# Article Fgtech Blog - 2021-11-30

Configuration de votre environnement Vault

## Configuration de la partie Vault kubernetes

```bash

export TF_VAR_cluster="k3d-podtato"

export VAULT_TOKEN="s.fA99WSCdYzfNkVJ3OqQyxcOk" # Pour le lab, utiliser le token root
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