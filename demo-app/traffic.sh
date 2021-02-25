#! /usr/bin/env bash

set -euox pipefail

while true
do
    curl https://demo-app.apps.$PRIMARY_DOMAIN/write
    sleep 1
done