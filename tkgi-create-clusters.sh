#! /usr/bin/env bash

# Change as you see fit. These numbers work for my lab and my workloads

tkgi create-cluster cluster1 \
--external-hostname=cluster1.$PRIMARY_DOMAIN \
--plan=medium \
--num-nodes=6


tkgi create-cluster tas \
--external-hostname=k8s-tas.$PRIMARY_DOMAIN \
--plan=medium \
--num-nodes=5