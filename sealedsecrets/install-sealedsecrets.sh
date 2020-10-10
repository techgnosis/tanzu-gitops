#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a sealed-secrets -f controller.yaml