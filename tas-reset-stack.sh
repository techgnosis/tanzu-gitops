#! /usr/bin/env bash

set -euo pipefail

kubectl patch stack cflinuxfs3-stack \
--namespace cf-workloads-staging \
--type='json' \
--patch='[{"op": "replace", "path": "/spec/buildImage/image", "value":"gcr.io/paketo-buildpacks/build@sha256:84f7b60192e69036cb363b2fc7d9834cff69dcbcf7aaf8c058d986fdee6941c3"},{"op": "replace", "path": "/spec/runImage/image", "value":"gcr.io/paketo-buildpacks/run@sha256:84f7b60192e69036cb363b2fc7d9834cff69dcbcf7aaf8c058d986fdee6941c3"}]'