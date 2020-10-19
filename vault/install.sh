#! /usr/bin/env bash

set -euo pipefail


helm install vault vault \
--repo https://helm.releases.hashicorp.com \
--namespace vault \
--create-namespace \
--version "0.7.0" \
--values values.yml

