#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a spring-petclinic -f manifests/spring-petclinic -y