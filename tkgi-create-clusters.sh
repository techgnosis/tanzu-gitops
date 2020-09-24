#! /usr/bin/env bash

# Uses the default plan "small" for everything
# Change as you see fit. These numbers work for my lab and my workloads

tkgi create-cluster concourse \
--external-hostname=k8s-concourse.$PRIMARY_DOMAIN \
--plan=small

tkgi create-cluster harbor \
--external-hostname=k8s-harbor.$PRIMARY_DOMAIN \
--plan=small

tkgi create-cluster tbs \
--external-hostname=k8s-tbs.$PRIMARY_DOMAIN \
--plan=small

tkgi create-cluster diy \
--external-hostname=k8s-diy.$PRIMARY_DOMAIN \
--plan=small

tkgi create-cluster kubeapps \
--external-hostname=k8s-kubeapps.$PRIMARY_DOMAIN \
--plan=small

# TAS4K8s won't install on less than 5 small workers
tkgi create-cluster tas \
--external-hostname=k8s-tas.$PRIMARY_DOMAIN \
--plan=small \
--num-nodes=5