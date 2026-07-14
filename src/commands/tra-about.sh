#!/usr/bin/env bash
#
# tra-about
#
# Prints project identity and a short description.

set -uo pipefail

version="unknown"
[ -r /etc/tra-version ] && version="$(cat /etc/tra-version)"

cat <<EOF
TheRealAnonymousRSA VPS  v${version}

A self-hosted, browser-based Ubuntu 24.04 terminal, built on ttyd, tmux,
and Docker. Run 'tra-help' to see the available commands.

License: MIT
EOF
