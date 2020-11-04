#! /usr/bin/env bash

set -euo pipefail

echo "Configuring DBs. This script can only be run once."
kubectl exec -it -n postgres-dbs ccdb-0 -- psql -d cloud_controller -c "CREATE EXTENSION citext"
kubectl exec -it -n postgres-dbs uaadb-0 -- psql -d uaa -c "CREATE EXTENSION citext"
kubectl exec -it -n postgres-dbs usagedb-0 -- psql -d usage_service -c "CREATE EXTENSION citext"

CCDBPW=`bosh interpolate --path='/data/password' <( kubectl get secret -n postgres-dbs ccdb-db-secret -o yaml ) | base64 --decode`
UAADBPW=`bosh interpolate --path='/data/password' <( kubectl get secret -n postgres-dbs uaadb-db-secret -o yaml ) | base64 --decode`
USAGEDBPW=`bosh interpolate --path='/data/password' <( kubectl get secret -n postgres-dbs usagedb-db-secret -o yaml ) | base64 --decode`

cat <<EOT
USAGE-SERVICE-DB-PASSWORD=${USAGEDBPW}
UAADB-PASSWORD=${UAADBPW}
CCDB-PASSWORD=${CCDBPW}
EOT