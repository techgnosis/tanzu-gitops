#! /usr/bin/env bash

set -euo pipefail

kp image create petclinic \
harbor.lab.home/library/petclinic \
--namespace tbs-demo \
--git https://github.com/spring-projects/spring-petclinic.git \
--git-revision main