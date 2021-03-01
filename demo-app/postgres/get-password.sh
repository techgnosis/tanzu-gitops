#! /usr/bin/env bash

set -euo pipefail

kubectl get secrets testdb-db-secret -n postgres-dbs -o jsonpath='{.data.password}' | base64 -d