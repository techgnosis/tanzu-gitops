#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a emojivoto-backend \
-f workaround.yml \
-f emojivoto/kustomize/deployment/emoji.yml \
-f emojivoto/kustomize/deployment/voting.yml