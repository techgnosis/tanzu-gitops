#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a vsphere-storage -f storageclass.yml