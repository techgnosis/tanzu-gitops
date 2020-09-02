#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a locust -f manifests/locust