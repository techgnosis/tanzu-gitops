#! /usr/bin/env bash

set -xeuo pipefail

DATE="2021-01-01"

charts-syncer sync --config tanzu-gitops/tac/tac.yaml --from-date $DATE
charts-syncer sync --config tanzu-gitops/tac/bitnami.yaml --from-date $DATE
charts-syncer sync --config tanzu-gitops/tac/concourse.yaml --from-date $DATE
charts-syncer sync --config tanzu-gitops/tac/jetstack.yaml --from-date $DATE