#! /usr/bin/env bash

set -euo pipefail

# Make the namespace for the PetClinic K8s resources
kubectl create ns tanzulab

# Make the Ingress TLS pem files locally on disk
mkcert \
-cert-file tls.crt \
-key-file tls.key \
petclinic.lab.home

# Make the TLS secret for PetClinic Ingress using the on-disk pem files
kubectl create secret tls petclinic-tls \
--namespace tanzulab \
--cert=./tls.crt \
--key=./tls.key

# Make registry secret for TBS
REGISTRY_PASSWORD=Harbor12345 kp secret create harbor2-creds \
--namespace tanzulab \
--registry harbor.lab.home \
--registry-user admin

# Setup TBS to build PetClinic
kp image create petclinic \
harbor.lab.home/library/petclinic \
--namespace tanzulab \
--git https://github.com/techgnosis/spring-petclinic.git \
--git-revision HEAD


