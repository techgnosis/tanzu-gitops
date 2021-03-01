#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a demo-app-postgres-database \
-n demo-app \
-f demo-app.yml