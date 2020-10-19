#! /usr/bin/env bash

set -euo pipefail

export UNSEAL_KEY=$1

kubectl exec -n vault -it vault-0 -- vault operator unseal $UNSEAL_KEY