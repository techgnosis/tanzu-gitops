#! /usr/bin/env bash

set -euo pipefail

NOTARY_SERVER_URL="https://notary.lab.home:4443"
IMAGE_REPOSITORY="harbor.lab.home/library/demo-app"

notary -s "${NOTARY_SERVER_URL}" init "${IMAGE_REPOSITORY}"
notary -s "${NOTARY_SERVER_URL}" key rotate "${IMAGE_REPOSITORY}" snapshot -r
notary -s "${NOTARY_SERVER_URL}" publish "${IMAGE_REPOSITORY}"