#! /usr/bin/env bash

set -euo pipefail

mkcert \
-cert-file tls.crt \
-key-file tls.key \
petclinic.lab.home

kubectl create ns petclinic

kubectl create secret tls petclinic-tls \
--namespace petclinic \
--cert=./tls.crt \
--key=./tls.key