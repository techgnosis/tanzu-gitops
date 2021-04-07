#! /usr/bin/env bash

set -euo pipefail

tmc cluster namespace create \
--cluster-name jmusselwhite-apps \
--provisioner-name myfriendthenamespace \
--management-cluster-name jmusselwhite \
--name emojivoto \
--workspace-name jmusselwhite-apps


tmc cluster namespace create \
--cluster-name jmusselwhite-databases \
--provisioner-name myfriendthenamespace \
--management-cluster-name jmusselwhite \
--name emojivoto \
--workspace-name jmusselwhite-databases


