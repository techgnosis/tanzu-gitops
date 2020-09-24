#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a harbor -f <(ytt --data-values-env=YTT_HARBOR -f manifests/harbor)