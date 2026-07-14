#!/usr/bin/env bash
#
# tra-ip
#
# Prints this container's IP address(es). This is the container's own
# network-namespace address, not necessarily what's reachable from the
# public internet - that depends on how you've published/proxied the port.

set -uo pipefail

echo "=== Container IP address(es) ==="
ip -brief address show 2>/dev/null | awk '$1 != "lo" {print $1": "$3}'

echo
echo "=== Hostname ==="
hostname
