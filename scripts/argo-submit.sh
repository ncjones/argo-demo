#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

argo_workflow_template="$1"

./argo-cli.sh submit \
    --namespace argo \
    --from "wftmpl/${argo_workflow_template}" \
    --wait || failed=yes

./argo-cli.sh get @latest
./argo-cli.sh logs @latest

[[ -z "${failed:-}" ]] || exit 1

