#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a minibroker -f minibroker.yml -f namespace.yml