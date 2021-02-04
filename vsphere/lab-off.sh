#! /usr/bin/env bash

set -euo pipefail

# there are 3 stages of autostart
# no autostart
# unordered autostart
# ordered autostart
# the default for host.autostart.add is unordered which is fine

# Note: turn off the hosts at the ESXi level
# If you use vCenter you might turn off the host that is running vCenter


function configure_autostart() {
    # I would use GOVC_URL but it doesnt work in the xargs statement
    ESXI_HOST=$1
    # using runtime.powerState to ignore stemcell VMs
    govc find -type m -u="$ESXI_HOST" . -runtime.powerState poweredOn | xargs -I {} govc host.autostart.add -u="$ESXI_HOST" "{}"
    govc host.autostart.info -u="$ESXI_HOST"
}

function shutdown_host() {
    ESXI_HOST=$1
    HOST_NAME=$2
    govc host.shutdown -u="$ESXI_HOST" -f=true "$HOST_NAME"
}

configure_autostart "https://top.rack.lab.home"
configure_autostart "https://middle.rack.lab.home"
configure_autostart "https://bottom.rack.lab.home"

shutdown_host "https://top.rack.lab.home" "top"
shutdown_host "https://middle.rack.lab.home" "middle"
shutdown_host "https://bottom.rack.lab.home" "bottom"




