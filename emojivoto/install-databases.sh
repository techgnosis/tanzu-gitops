#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a emojivoto \
-f ns.yml \
-f emojivoto/kustomize/deployment/emoji.yml \
-f emojivoto/kustomize/deployment/voting.yml