#!/usr/bin/env bash
#
# tra-version
#
# Prints this project's version plus the underlying system/ttyd versions.

set -uo pipefail

version="unknown"
[ -r /etc/tra-version ] && version="$(cat /etc/tra-version)"

echo "TheRealAnonymousRSA VPS v${version}"
echo
/opt/tra/system/sysinfo.sh
