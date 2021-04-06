#! /usr/bin/env bash

set -euo pipefail

kubectl apply -f app-developer.yml -f psp-disable.yml