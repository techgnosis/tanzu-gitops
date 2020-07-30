#! /usr/bin/env bash

set -euo pipefail

SECRET=$1
VALUE=$2

vault write concourse/main/"${SECRET}" value="${VALUE}"