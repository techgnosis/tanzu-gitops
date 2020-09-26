#! /usr/bin/env bash

# Change as you see fit. These numbers work for my lab and my workloads

tkgi create-cluster cluster1 \
--external-hostname=cluster1.$PRIMARY_DOMAIN \
--plan=medium \
--num-nodes=6

# TAS4K8s won't install on less than 5 small workers
tkgi create-cluster tas \
--external-hostname=k8s-tas.$PRIMARY_DOMAIN \
--plan=small \
--num-nodes=5