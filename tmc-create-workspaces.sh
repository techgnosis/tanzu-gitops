#! /usr/bin/env bash

set -euo pipefail

tmc workspace create -n base-platform -d "base platform shared by all app teams"
tmc workspace create -n spring-petclinic -d "spring-petclinic"