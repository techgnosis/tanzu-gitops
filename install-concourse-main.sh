#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a concourse-main -f manifests/concourse-main