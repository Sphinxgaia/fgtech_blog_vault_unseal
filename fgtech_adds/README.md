# Article Fgtech Blog - 2021-11-30

Assurez-vous d'avoir lancer la partie Vault en amont de ce test : [Vault-AutoUnseal](../vault)

## Lancement podtatohead - Intégration Vault

```bash

export myns_vault=podtato-kubectl-vault

kubectl create ns $myns_vault

kubectl -n $myns_vault apply -f vault-manifest.yaml

kubectl port-forward -n podtato-kubectl-vault svc/podtato-main 9000:9000
```

Ouvrez votre navigateur sur le port 9000

```bash
kubectl patch deployment -n $myns_vault podtato-hats --patch "$(cat vault-injector-patch.yaml)"

kubectl patch deployment -n $myns_vault podtato-left-arm --patch "$(cat vault-injector-patch.yaml)"

kubectl patch deployment -n $myns_vault podtato-right-arm --patch "$(cat vault-injector-patch.yaml)"

kubectl patch deployment -n $myns_vault podtato-left-leg --patch "$(cat vault-injector-patch.yaml)"

kubectl patch deployment -n $myns_vault podtato-right-leg --patch "$(cat vault-injector-patch.yaml)"


kubectl patch deployment -n $myns_vault podtato-body --patch "$(cat vault-injector-patch.yaml)"

```

Actualisez votre navigateur

Mettez à jour main pour voir la vrai version de notre application

```bash
kubectl patch deployment -n $myns_vault podtato-main --patch "$(cat vault-injector-patch-main.yaml)"

kubectl port-forward -n podtato-kubectl-vault svc/podtato-main 9000:9000
```

Rafraichir votre navigateur sur le port 9000

## Lancement podtatohead - Intégration Vault CSI

> Le driver CSI de Vault est encore en beta


```bash
export myns_vault=podtato-kubectl-csi
kubectl create ns $myns_vault

kubectl -n $myns_vault apply -f vault-csi-secret.yaml
kubectl -n $myns_vault apply -f vault-manifest.yaml
```

## Troubleshooting

```bash
kubectl apply -f -n $myns_vault debug.yaml

kubectl -n $myns_vault exec -it podtato-debug -c server -- bin/sh -c "cat /secret/version"

kubectl -n $myns_vault exec -it podtato-debug -c server -- sh

```