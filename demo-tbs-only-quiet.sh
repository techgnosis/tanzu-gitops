#! /usr/bin/env bash

source ./demo-magic.sh

clear

pe 'kp build logs spring-petclinic -n images'
pe 'tbs/tbs-update-stack-100.0.30.sh'
pe 'kp build logs spring-petclinic -n images'
