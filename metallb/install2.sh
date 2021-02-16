#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a metallb \
-f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml \
-f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml \
-f config2.yml \
-f <(kubectl create secret generic \
-n metallb-system memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)" \
--dry-run=client \
-o yaml)
