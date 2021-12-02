# Article Fgtech Blog - 2021-11-30

Démarrer un vault de dev

## Lancement d'un conteneur Vault en mode dev

> Mettre votre conteneur dans un réseau, vous facilitera le travail si vous souhaitez pousser l'exemple du Vault Transit en mode conteneur.

```bash
docker network create unseal-test

docker container run --network unseal-test --name mydev_vault -d -p 8200:8200 -e VAULT_API_ADDR=http://0.0.0.0:8200 vault:1.8.2 vault server -dev -dev-root-token-id="root" -dev-listen-address="0.0.0.0:8200"
```

En mode dev, Vault est directement unseal et disponible


## Activation du point de montage transit

```bash

docker container exec -it mydev_vault bin/sh -c "export VAULT_TOKEN=root; export VAULT_ADDR=http://127.0.0.1:8200; vault secrets enable transit"

docker container exec -it mydev_vault bin/sh -c "export VAULT_TOKEN=root; export VAULT_ADDR=http://127.0.0.1:8200; vault write -f transit/keys/autounseal"


docker container exec -it mydev_vault bin/sh -c 'tee autounseal.hcl <<EOF

path "secret/data/test" {
   capabilities = [ "read" ]
}

path "transit/encrypt/autounseal" {
   capabilities = [ "update" ]
}

path "transit/decrypt/autounseal" {
   capabilities = [ "update" ]
}
EOF
'

docker container exec -it mydev_vault bin/sh -c 'export VAULT_TOKEN=root; export VAULT_ADDR=http://127.0.0.1:8200; vault policy write autounseal autounseal.hcl'

docker container exec -it mydev_vault bin/sh -c 'export VAULT_TOKEN=root; export VAULT_ADDR=http://127.0.0.1:8200; vault token create -policy="autounseal"'
```

```console
Success! Uploaded policy: autounseal
Key                  Value
---                  -----
token                s.fvamD02tL1heErlWvf2FYcWq
token_accessor       icoufNWnzKD6PnOv1Zjh7oOI
token_duration       768h
token_renewable      true
token_policies       ["autounseal" "default"]
identity_policies    []
policies             ["autounseal" "default"]
```

Test de votre token

```bash

docker container exec -it mydev_vault bin/sh -c 'export VAULT_TOKEN=root; export VAULT_ADDR=http://127.0.0.1:8200; vault kv put secret/test titi=tata'


export YOUR_TOKEN=previous_token

docker container exec -it mydev_vault bin/sh -c "export VAULT_TOKEN=$YOUR_TOKEN; export VAULT_ADDR=http://127.0.0.1:8200; vault kv get secret/test"

```

## Exemple de configuration pour la partie Auto-unseal

Tester la connectivité entre vos instances vault

Lancer un conteneur en mode dev temporaire puis connectez-vous au Vault principal `VAULT_ADDR=http://mydev_vault:8200`

```bash
docker container run --network unseal-test --name mychild_vault -d -p 8100:8100 -e VAULT_API_ADDR=http://0.0.0.0:8100 vault:1.8.2 vault server -dev -dev-root-token-id="root" -dev-listen-address="0.0.0.0:8200"


docker container exec -it mydev_vault bin/sh -c "export VAULT_TOKEN=$YOUR_TOKEN; export VAULT_ADDR=http://mydev_vault:8200; vault kv get secret/test"

docker container run -f mychild_vault
```

Prendre le fichier de config d'auto-unseal suivant

```hcl
disable_mlock = true
ui=true

storage "file" {
  path = "/vault/data"
}

listener "tcp" {
  address     = "127.0.0.1:8100"
  tls_disable = "true"
}

seal "transit" {
  address = "http://mydev_vault:8200"
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "transit/"
  tls_skip_verify = "true"
}
```

Démarrer votre vault enfant avec le token VAULT permettant de se connecter à la clé de transit fait le nécessaire pour initialiser votre Vault.

Suivez la doc : https://learn.hashicorp.com/tutorials/vault/autounseal-transit?in=vault/auto-unseal#step-2-configure-auto-unseal-vault-2


