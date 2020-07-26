#! /usr/bin/env bash

set -euo pipefail

fluxctl automate \
--workload=deployment/petclinic \
--namespace petclinic \
--k8s-fwd-ns petclinic


