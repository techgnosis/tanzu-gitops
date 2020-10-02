#! /usr/bin/env bash

set -euo pipefail


helm install concourse harbor/library/concourse \
--create-namespace \
--namespace concourse \
--version 11.4.0 \
--values manifests/concourse/helm.yml \
--set concourse.web.externalUrl="https://$YTT_CONCOURSE_concourse_hostname" \
--set web.ingress.hosts={$YTT_CONCOURSE_concourse_hostname} \
--set web.ingress.tls[0].hosts={$YTT_CONCOURSE_concourse_hostname} \
--wait

kapp deploy \
-a concourse \
-f <(ytt --data-values-env=YTT_CONCOURSE \
-f manifests/concourse/certificate.yml \
-f manifests/concourse/values.yml)
