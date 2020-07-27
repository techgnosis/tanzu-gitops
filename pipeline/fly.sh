#! /usr/bin/env bash

set -euo pipefail

source vars.sh

fly set-pipeline -t lab \
-p petclinic \
-c pipeline.yml \
-v tkgicluster="${TKGICLUSTER}" \
-v tkgiapi="${TKGIAPI}" \
-v tkgiuser="${TKGIUSER}" \
-v tkgipassword="${TKGIPASSWORD}" \
-v harborca="${HARBORCA}"

