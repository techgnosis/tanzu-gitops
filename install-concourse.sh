#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a concourse -f <(ytt --data-values-env=YTT_CONCOURSE -f manifests/concourse)