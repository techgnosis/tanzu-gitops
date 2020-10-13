#! /usr/bin/env bash

set -euo pipefail

kubectl patch stack cflinuxfs3-stack \
--namespace cf-workloads-staging \
--type='json' \
--patch='[{"op": "replace", "path": "/spec/buildImage/image", "value":"gcr.io/paketo-buildpacks/build@sha256:a591ad9c9bb81d1d74ed29b930fe6fc8bf1b296a5c61291beca848aee4c94925"},{"op": "replace", "path": "/spec/runImage/image", "value":"gcr.io/paketo-buildpacks/run@sha256:12f8ebe599e62c7113dab4cac7290f87c46dcb388dd3bcdfa02860ba77424ec6"}]'