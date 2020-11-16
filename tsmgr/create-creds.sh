#! /usr/bin/env bash

set -euo pipefail


# This file creates cluster-creds.yaml which is required
# by KSM when adding a cluster to KSM

kube_config="$HOME/.kube/config"

cluster=`grep current $kube_config|sed "s/ //g"|cut -d ":" -f 2`

echo "Using cluster $cluster"

server=`grep -B 2 "name: $cluster" $kube_config \
  |grep server|sed "s/ //g"|sed "s/^[^:]*://g"`

certificate=`grep -B 2 "name: $cluster" $kube_config \
  |grep certificate|sed "s/ //g"|sed "s/.*://"`

secret_name=$(kubectl get serviceaccount ksm-admin \
 --namespace=kube-system -o jsonpath='{.secrets[0].name}')

secret_val=$(kubectl --namespace=kube-system get secret $secret_name \
 -o jsonpath='{.data.token}')

secret_val=$(echo ${secret_val} | base64 --decode)

echo $server

echo $certificate

echo $secret_val 

cat > cluster-creds.yaml << EOF
token: ${secret_val}
server: ${server}
caData: ${certificate}
EOF