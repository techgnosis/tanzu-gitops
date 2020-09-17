#! /usr/bin/env bash

set -euo pipefail

ytt --data-values-env=YTT_CONCOURSE -f manifests/concourse \
| kapp deploy -a concourse -f- -y