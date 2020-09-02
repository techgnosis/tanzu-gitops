#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a contour -f manifests/contour/contour.yml
