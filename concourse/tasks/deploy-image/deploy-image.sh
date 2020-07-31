#! /usr/bin/env bash

set -xeuo pipefail

pks login -a ${tkgiapi} \
-u ${tkgiuser} \
-p ${tkgipassword} \
-k

pks get-credentials ${tkgicluster}

git clone deploy-source deploy-source-modified

export DIGEST=$(cat image/digest)

sd harbor.lab.home/library/$imagename.+ harbor.lab.home/library/$imagename@$DIGEST deploy-source-modified/manifests/$imagename/deployment.yml

# deploy it
kapp deploy -a $imagename -c -y -f deploy-source-modified/manifests

git config --global user.email "concourse@lab.home"
git config --global user.name "Concourse"

cd deploy-source-modified
git add manifests/$imagename/deployment.yml
git commit -m "Updating deployment to use new image"