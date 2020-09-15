#! /usr/bin/env bash

set -euo pipefail

ytt --data-values-env=YTT_TBS -f manifests/images \
| kapp deploy -a images -f- -y