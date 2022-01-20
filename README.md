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
kubectl --context kind-argo -n argo port-forward svc/argo-argo-workflows-server 2746:80
open http://localhost:2746
```

## Get Argo Auth Token

```
scripts/argo-token.sh
```


## Debugging

### Cleanup Kubernetes Cluster

```
kind delete cluster --name argo
```

### Update Helm Dependencies

After modifying dependencies in Chart.yaml, delete Chart.lock
and run:

```
cd helm/argo
helm dep update
```
