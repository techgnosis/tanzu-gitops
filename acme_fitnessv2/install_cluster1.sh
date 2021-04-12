#! /usr/bin/env bash

set -euo pipefail

kapp deploy \
--into-ns acme-fitness \
-a acme-fitness-cluster1 \
-f cluster1.yml \
-f secrets.yml \
-f istio.yml