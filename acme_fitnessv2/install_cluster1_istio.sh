#! /usr/bin/env bash

set -euo pipefail

kapp deploy \
-a acme-fitness-cluster1-istio \
-f istio.yml