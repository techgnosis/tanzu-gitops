#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a flagger -f manifests/flagger/flagger.yaml
