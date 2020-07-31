#! /usr/bin/env bash

set -euo pipefail

mkcert -cert-file tls.crt \
-key-file tls.key \
harbor.lab.home


export CA_PATH="$(mkcert -CAROOT)"/rootCA.pem
cp "$CA_PATH" .

kubectl create ns harbor

kubectl create secret generic harbor \
--from-file=./tls.crt \
--from-file=./tls.key \
--from-file=./rootCA.pem \
--namespace harbor