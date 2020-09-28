#! /usr/bin/env bash

set -euo pipefail

velero plugin add vsphereveleroplugin/velero-plugin-for-vsphere:1.0.2

velero snapshot-location create vsl-vsphere --provider velero.io/vsphere