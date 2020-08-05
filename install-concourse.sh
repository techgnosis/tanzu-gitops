#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a concourse -f manifests/concourse