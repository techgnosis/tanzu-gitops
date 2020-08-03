#! /usr/bin/env bash

set -euo pipefail

START_TIME=$(date +%s000)
sleep 1
END_TIME=$(date +%s000)


curl \
-X POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--header "Authorization: Bearer ${WAVEFRONT_API_TOKEN}" \
-d "{
  \"name\": \"tanzu-gitops-spring-petclinic-deploy\",
  \"annotations\": {
    \"severity\": \"info\",
    \"type\": \"image deploy\",
    \"details\": \"new spring-petclinic image deployed\"
  },
\"startTime\": "${START_TIME}",
  \"endTime\": "${END_TIME}"
}" "${WAVEFRONT_URL}/api/v2/event"