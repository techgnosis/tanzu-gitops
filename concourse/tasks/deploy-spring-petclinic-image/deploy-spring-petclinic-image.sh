#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

git clone tanzu-gitops tanzu-gitops-modified

export DIGEST=$(cat spring-petclinic-image/digest)

sd harbor.lab.home/library/spring-petclinic.+ harbor.lab.home/library/spring-petclinic@$DIGEST tanzu-gitops-modified/manifests/spring-petclinic/rollout.yml

# deploy it
kubectl apply -f tanzu-gitops-modified/manifests/spring-petclinic

git config --global user.email "concourse@lab.home"
git config --global user.name "Concourse"

cd tanzu-gitops-modified
git add manifests/spring-petclinic/deployment.yml
git commit -m "Updating deployment to use new image"