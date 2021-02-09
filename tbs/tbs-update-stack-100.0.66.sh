#! /usr/bin/env bash

set -euo pipefail

kp clusterstack update base \
--build-image=registry.pivotal.io/tanzu-base-bionic-stack/build@sha256:3230de1daa9b37ddc5f38ea6f9a208e2f911d4e187baa3fa3c9f0630dbb018bb \
--run-image=registry.pivotal.io/tanzu-base-bionic-stack/run@sha256:70accedc26b4d9230ce6ae4b1e55a0588bb14447e074d8fc65bd3ced4211630b