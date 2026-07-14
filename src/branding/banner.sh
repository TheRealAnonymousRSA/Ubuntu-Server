#!/usr/bin/env bash
#
# src/branding/banner.sh
#
# Prints the project banner, a version tagline, and a live system-info
# snapshot. Run once by entrypoint.sh at container startup (for `docker
# logs` visibility) and again on every interactive login via
# /etc/profile.d/00-tra-shell.sh (i.e. every new browser terminal
# connection / tmux reattach).

set -uo pipefail

if [ -r /etc/tra-banner.txt ]; then
    cat /etc/tra-banner.txt
else
    echo "TheRealAnonymousRSA VPS"
fi

version="unknown"
[ -r /etc/tra-version ] && version="$(cat /etc/tra-version)"
echo
echo "  v${version}  -  type 'tra-help' to see available commands"
echo
/opt/tra/system/sysinfo.sh
echo
