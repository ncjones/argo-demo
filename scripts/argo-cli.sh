#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

argo_server=argo-argo-workflows-server:80
argo_token="$(./argo-token.sh)"

kubectl run -q argo-cli \
  -i \
  --rm \
  --restart=Never \
  --image bitnami/argo-workflow-cli \
  -n argo \
  --env "ARGO_SECURE=false" \
  --env "ARGO_TOKEN=${argo_token}" \
  --env "ARGO_SERVER=${argo_server}" \
  -- \
  "$@"
