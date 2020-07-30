#! /usr/bin/env bash

set -euo pipefail

source vars.sh

fly set-pipeline -t lab \
-p derp \
-c pipeline.yml \
-v role_id="${ROLE_ID}" \
-v secret_id="${SECRET_ID}" \
-v ca_cert="${CACERT}"
# -v tkgicluster="${TKGICLUSTER}" \
# -v tkgiapi="${TKGIAPI}" \
# -v tkgiuser="${TKGIUSER}" \
# -v tkgipassword="${TKGIPASSWORD}" \
# -v harborca="${HARBORCA}" \
# -v namespace="${NAMESPACE}" \
# -v imagename="${IMAGENAME}" \
# -v privatekey="${PRIVATEKEY}" \
# -v role_id="${ROLE_ID}" \
# -v secret_id="${SECRET_ID}"

