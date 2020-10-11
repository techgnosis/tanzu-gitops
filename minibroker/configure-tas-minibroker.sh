#! /usr/bin/env bash

set -euo pipefail


cf create-service-broker minibroker user pass http://minibroker-minibroker.minibroker.svc.cluster.local
# Postgres and RabbitMQ don't work despite the docs saying they do
cf enable-service-access redis
cf enable-service-access mysql
cf enable-service-access mongodb