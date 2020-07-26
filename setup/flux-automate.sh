#! /usr/bin/env bash

set -euo pipefail

fluxctl automate \
--workload=petclinic:deployment/petclinic \
--k8s-fwd-ns petclinic


