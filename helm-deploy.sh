#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

env=local
project=
version=

while [[ $# -gt 0 ]]; do
  case $1 in
    --env)
      shift
      env="$1"
    ;;
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

if [[ -z "${env}" ]]; then
  >&2 echo "Missing --env arg"
  exit 1
fi

if [[ -z "${project}" ]]; then
  >&2 echo "Missing --project arg"
  exit 1
fi

if [[ -z "${version}" ]]; then
  >&2 echo "Missing --version arg"
  exit 1
fi

package="dist/${project}-${version}.tgz"
namespace="argo"

if [ ! -f "${package}" ]; then
  echo "Chart package missing: ${package}" >&2
  exit 1
fi

helm upgrade "${project}" "${package}" \
  -f "helm/${project}/${env}-values.yaml" \
  --install \
  --wait \
  --create-namespace \
  --namespace "${namespace}"
