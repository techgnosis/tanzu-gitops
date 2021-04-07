#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a emojivoto-frontend \
-f emojivoto/kustomize/deployment/vote-bot.yml \
-f emojivoto/kustomize/deployment/web.yml
