#!/bin/bash

set -euo pipefail

secret_name="$(kubectl get sa -n argo argo-argo-workflows-server -o=jsonpath='{.secrets[0].name}')"
echo "Bearer $(kubectl get secret -n argo "${secret_name}" -o=jsonpath='{.data.token}' | base64 --decode)"
