#! /usr/bin/env bash

set -euo pipefail

NAMESPACE=$1
URL=$2
FILE=register-management-cluster.yml

cp $FILE.template $FILE

sd "<THENAMESPACE>" $NAMESPACE $FILE
sd "<THEURL>" $URL $FILE

kapp deploy -a tsm-management-registration -f $FILE