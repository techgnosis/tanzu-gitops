#! /usr/bin/env bash

set -euo pipefail

# -helm upgrade --install contour contour \
# ---repo https://charts.trials.tac.bitnami.com/demo \
# ---version 4.1.1 \
# ---wait \
# ---namespace contour \
# ---create-namespace


kapp deploy -a contour \
-f https://projectcontour.io/quickstart/contour.yaml