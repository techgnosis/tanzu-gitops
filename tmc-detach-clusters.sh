#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget jmusselwhite-harbor
kubectx harbor && kapp delete -a tmc

tmc cluster delete --forget jmusselwhite-tbs
kubectx tbs && kapp delete -a tmc

tmc cluster delete --forget jmusselwhite-concourse
kubectx concourse && kapp delete -a tmc

tmc cluster delete --forget jmusselwhite-spring-petclinic-non-prod
kubectx spring-petclinic-non-prod && kapp delete -a tmc

tmc cluster delete --forget jmusselwhite-spring-petclinic-prod
kubectx spring-petclinic-prod && kapp delete -a tmc

tmc cluster delete --forget jmusselwhite-kubeapps
kubectx kubeapps && kapp delete -a tmc