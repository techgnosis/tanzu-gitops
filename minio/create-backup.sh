#! /usr/bin/env bash

set -euo pipefail

velero backup create my-backup \
--snapshot-volumes \
--volume-snapshot-locations vsl-vsphere