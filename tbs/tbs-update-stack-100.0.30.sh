#! /usr/bin/env bash

set -euo pipefail

kp clusterstack update base \
--build-image=registry.pivotal.io/tbs-dependencies/build-base:202010201325 \
--run-image=registry.pivotal.io/tbs-dependencies/run-base:202010201325