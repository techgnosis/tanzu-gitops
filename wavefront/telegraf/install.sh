#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a telegraf \
-f telegraf.yml \
-f config.yml