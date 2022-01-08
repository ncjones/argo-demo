#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."

echo "kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraMounts:
  - hostPath: $(pwd)
    containerPath: /work"
