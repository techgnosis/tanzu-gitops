#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a node-exporter -f manifests/node-exporter