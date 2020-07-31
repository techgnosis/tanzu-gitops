#! /usr/bin/env bash

set -euo pipefail

source vars.sh

fly login \
--target=lab \
--concourse-url="https://concourse.lab.home" \
--username=test \
--password=test

fly set-pipeline -t lab \
-p tanzulab \
-c pipeline.yml \
-v role_id="${ROLE_ID}" \
-v secret_id="${SECRET_ID}" \
-v ca_cert="${CA_CERT}"
