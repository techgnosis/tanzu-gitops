#! /usr/bin/env bash

set -euo pipefail

NAME=$1

# best-effort-medium is 2/8
# best-effort-xlarge is 4/32

tmc cluster create \
--template tkgs \
--allowed-storage-classes vsan-default-storage-policy \
--storage-class vsan-default-storage-policy \
--default-storage-class vsan-default-storage-policy \
--version v1.19.7+vmware.1-tkg.1.fc82c41 \
--cluster-group jmusselwhite \
--instance-type best-effort-medium \
--worker-instance-type best-effort-xlarge \
--worker-node-count 3 \
--name $NAME