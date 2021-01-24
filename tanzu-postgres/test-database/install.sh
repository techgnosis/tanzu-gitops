#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a postgres-test-database \
-f testdb.yml \
-f pgweb.yml