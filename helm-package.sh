#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

project=
version=

while [[ $# -gt 0 ]]; do
  case $1 in
    --project)
      shift
      project="$1"
    ;;
    --version)
      shift
      version="$1"
    ;;
  esac
  shift
done

if [[ -z "${project}" ]]; then
  >&2 echo "Missing --project arg"
  exit 1
fi

if [[ -z "${version}" ]]; then
  >&2 echo "Missing --version arg"
  exit 1
fi

if [[ -d "helm/${project}/charts" ]]; then
  >&2 echo "helm/${project}/charts dir exists, skipping helm dependencies"
else
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm dep build --verify "helm/${project}"
fi
helm package -d dist "helm/${project}" "--version=${version}"
