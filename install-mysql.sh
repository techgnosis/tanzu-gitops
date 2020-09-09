#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a mysql -f manifests/mysql -y