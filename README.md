# Argo Demo


## Dependencies

```
brew install kind kubectl helm
```

## Create Kubernetes Cluster

```
kind create cluster --config <(scripts/kind-config.sh)
```


## Setup Argo

```
./helm-package.sh --project argo --version 1
./helm-deploy.sh --project argo --version 1
```

## Inspect Argo UI

```
kubectl -n argo port-forward deployment/argo-server 2746:2746
open https://localhost:2746
```

## Get Argo Auth Token

```
secret_name="$(kubectl get sa -n argo argo-argo-workflows-server -o=jsonpath='{.secrets[0].name}')"
echo "Bearer $(kubectl get secret -n argo "${secret_name}" -o=jsonpath='{.data.token}' | base64 --decode)"
```


## Debugging

### Cleanup Kubernetes Cluster

```
kind delete cluster
```

### Update Helm Dependencies

After modifying dependencies in Chart.yaml, delete Chart.lock
and run:

```
cd helm/argo
helm dep update
```
