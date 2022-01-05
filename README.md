# Argo Demo


## Create Kubernetes Cluster

There must be a running Kubernetes cluster available.

```
brew install kind
kind create cluster
```

OR

```
brew install k3d
k3d cluster create mycluster
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

OR

```
k3d cluster delete mycluster
```

### Update Helm Dependencies

After modifying dependencies in Chart.yaml, delete Chart.lock
and run:

```
cd helm/argo
helm dep update
```
