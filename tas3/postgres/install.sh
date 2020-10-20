#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a postgres \
-f namespace.yml \
-f postgres.yml