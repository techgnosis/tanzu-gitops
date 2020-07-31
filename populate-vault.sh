#! /usr/bin/env bash

set -euo pipefail

# TKGI
vault write concourse/main/tkgicluster value=""
vault write concourse/main/tkgiapi value=""
vault write concourse/main/tkgiuser value=""
vault write concourse/main/tkgipassword value=""


vault write concourse/main/ca_cert value=""
vault write concourse/main/concourse_github_privatekey value=""


