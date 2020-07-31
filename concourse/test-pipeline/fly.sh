#! /usr/bin/env bash

set -euo pipefail

source vars.sh

fly set-pipeline -t lab \
-p test-pipeline \
-c pipeline.yml \
-v role_id="${ROLE_ID}" \
-v secret_id="${SECRET_ID}" \
-v ca_cert="${CA_CERT}"
