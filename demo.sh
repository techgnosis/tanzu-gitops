#! /usr/bin/env bash

source ./demo-magic.sh

clear

# p 'Welcome. Lets get started by showing an existing pipeline. Trigger it in GitHub'

# pe 'kp build logs product-api -n images'



# p 'Lets update to a new stack'
# pe 'tbs/tbs-update-stack-100.0.30.sh'
# pe 'kp build logs product-api -n images'

# p 'Lets add a new Spring Boot application to our environment. The app is called spring-petclinic'
# p 'First step is to put the MySQL chart into Harbor'
# pe 'cat tac/sync.sh'
# pe 'cd tac'
# pe './sync.sh'
# pe 'cd ..'
# p 'Lets take a look at Harbor Helm repo and our image replication'



# p 'Helm repo is ready. Lets login as our spring-petclinic developer and begin deploying'
# pe 'tkgi get-kubeconfig cluster2 --username spring-petclinic-dev --password spring-petclinic-dev --api https://tkgi.lab.home'
# p 'We havent been assigned any permissions yet. Lets confirm'
# pe 'kubectl get pods -n product-api'
# pe 'kubectl get pods -n spring-petclinic'
# pe 'cd apps/spring-petclinic/mysql'
# pe './install.sh'
# pe 'cd ../../..'
# p 'It seems we lack permissons. Lets fix that in Tanzu Mission Control'
# pe 'kubectl get pods -n product-api'
# pe 'kubectl get pods -n spring-petclinic'
# p 'Lets try our install again'
# pe 'cd apps/spring-petclinic/mysql'
# pe './install.sh'
# pe 'cd ..'
# pe './install.sh'








