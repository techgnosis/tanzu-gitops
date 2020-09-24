#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a mariadb-galera -f manifests/mariadb-galera