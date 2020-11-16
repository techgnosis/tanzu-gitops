#! /usr/bin/env bash

set -euo pipefail

export KSM_TARGET=http://daemon.ksm.lab.home
export KSM_USER=admin
export KSM_PASSWORD=$(kubectl get secret -n ksm ksm-ksm-daemon  -o=jsonpath='{@.data.SECURITY_USER_PASSWORD}' | base64 --decode)