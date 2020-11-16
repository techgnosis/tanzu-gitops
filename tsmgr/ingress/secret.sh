#! /usr/bin/env bash

set -euo pipefail

mkcert \
-cert-file tls.crt \
-key-file tls.key \
daemon.broker.lab.home \
broker.broker.lab.home \
broker.lab.home

kubectl create ns ksm

kubectl create secret tls broker-tls \
--namespace ksm \
--cert=./tls.crt \
--key=./tls.key