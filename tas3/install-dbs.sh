#! /usr/bin/env bash

set -euo pipefail

echo "Installing Postgres databases needed for TAS"
kapp deploy -a tas3-dbs -f postgres-dbs.yml