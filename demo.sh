#! /usr/bin/env bash

source ./demo-magic.sh

clear

p 'Welcome. Lets get started by showing an existing pipeline'

pe 'kp build logs product-api -n images'



p 'Lets update to a new stack'
pe 'tbs/tbs-update-stack-100.0.30.sh'
pe 'kp build logs product-api -n images'

p 'Lets add a new Spring Boot application to our environment'
p 'Lets login as our spring-petclinic developer'
pe 'tkgi get-kubeconfig cluster1 --username spring-petclinic-dev --password spring-petclinic-dev --api https://tkgi.lab.home'
pe 'kubectl get pods -n product-api'
pe 'kubectl get pods -n spring-petclinic'


p 'Lets sync the MySQL chart to Harbor'
pe 'cat tac/sync-mysql.sh'
pe 'tac/sync-mysql.sh'


p 'Lets try to deploy MySQL'
pe 'apps/spring-petclinic/mysql/install.sh'
pe 'helm uninstall mysql -n spring-petclinic'

p 'Lets grant access in TMC'
pe 'kubectl get ns'
pe 'kubectl get pods -n spring-petclinic'
p 'Lets try our install again'
pe 'apps/spring-petclinic/mysql/install.sh'
pe 'apps/spring-petclinic/install.sh'
