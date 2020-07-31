#! /usr/bin/env bash

set -euo pipefail

# Make the namespace for the PetClinic K8s resources
kubectl create ns spring-petclinic

# Make the Ingress TLS pem files locally on disk
mkcert \
-cert-file tls.crt \
-key-file tls.key \
spring-petclinic.lab.home

# Make the TLS secret for PetClinic Ingress using the on-disk pem files
kubectl create secret tls spring-petclinic-tls \
--namespace spring-petclinic \
--cert=./tls.crt \
--key=./tls.key

# Make registry secret for TBS
REGISTRY_PASSWORD=Harbor12345 kp secret create harbor2-creds \
--namespace spring-petclinic \
--registry harbor.lab.home \
--registry-user admin

# Setup TBS to build PetClinic
kp image create spring-petclinic \
harbor.lab.home/library/spring-petclinic \
--namespace spring-petclinic \
--git https://github.com/techgnosis/spring-petclinic.git \
--git-revision bedb97afb61dd4422d6719c30838194841c5caec


