#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a contour \
-f https://projectcontour.io/quickstart/contour.yaml