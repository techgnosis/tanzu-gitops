#! /usr/bin/env bash

set -euo pipefail

kapp deploy \
--into-ns acme-fitness \
-a acme-fitness-cluster2 \
-f cluster2.yml \
-f secrets.yml