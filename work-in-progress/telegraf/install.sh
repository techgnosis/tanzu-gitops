#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a telegraf \
-f namespace.yml \
-f telegraf.yml \
-f config.yml \
-f cluster-role-binding.yml \
-f service-account.yml