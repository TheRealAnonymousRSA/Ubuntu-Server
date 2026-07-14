#!/usr/bin/env bash
#
# tra-network
#
# Network overview: interfaces, addresses, default route, and listening
# ports. `ping` and `traceroute` are installed and usable directly - this
# command doesn't wrap them since they need no wrapping.

set -uo pipefail

echo "=== Network interfaces ==="
ip -brief address show 2>/dev/null || ifconfig -a

echo
echo "=== Default route ==="
ip route show default 2>/dev/null || route -n

echo
echo "=== Listening ports ==="
if command -v ss >/dev/null 2>&1; then
    ss -tulnp 2>/dev/null || ss -tuln
else
    netstat -tulnp 2>/dev/null || netstat -tuln
fi

echo
echo "Tip: 'ping <host>' and 'traceroute <host>' are both installed and ready to use."
