# Article Fgtech Blog - 2021-11-30

Dasn cet article, nous allons :

- lancer plusieurs intances de Vault (en mode auto-unseal)

- lancer l'application podtatohead

- connecter l'application à Vault

- changer les paramètres dans Vault

- tester la résilience de Vault & Kubernetes

## Lancement de l'application podtatohead

Lancer votre application :

```bash
kubectl apply -f simple-manifest.yaml
```

Selon vos paramètres, ouvrez une connexion avec votre application :

> Adapter le code du service en fonction de votre besoin

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: podtato-main
  namespace: podtato-kubectl
  labels:
    app: podtato-head
spec:
  selector:
    component: podtato-main
  ports:
  - name: http
    port: 9000
    protocol: TCP
    targetPort: 9000
  type: LoadBalancer
  # change to NodePort if no LoadBalancer controller is available
  # type: NodePort
```

Nous assumons donc que vous avez accès à votre cluster

```bash
kubectl port-forward -n podtato-kubectl svc/podtato-main 9000:9000
```


## Intégration vault

[Documentation](./fgtech_adds)