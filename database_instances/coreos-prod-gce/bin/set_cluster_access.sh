#!/bin/bash

# Setup Client SSH Tunnels
ssh-add ~/.ssh/google_compute_engine &>/dev/null

# SET
# path to the cluster folder where we store our binary files
export PATH=${HOME}/coreos-prod-gce/bin:$PATH
# fleet tunnel
export FLEETCTL_TUNNEL=35.200.95.0
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false

echo "list fleet machines:"
fleetctl list-machines

echo "list fleet units:"
fleetctl list-units

/bin/bash
