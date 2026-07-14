#!/usr/bin/env bash
#
# tra-help
#
# Lists the available tra-* commands.

set -uo pipefail

cat <<'EOF'
TheRealAnonymousRSA VPS - available commands

  tra-status      System snapshot: resources, ttyd, tmux session, health
  tra-update      apt-get update && apt-get upgrade -y
  tra-install     One-command installers (node, python, git, docker, curl,
                  ffmpeg, nano, vim, build-tools) or any apt package name
  tra-network     Interfaces, default route, listening ports
  tra-storage     Disk usage overview and largest directories
  tra-ip          This container's IP address(es) and hostname
  tra-speedtest   Lightweight download-throughput test
  tra-logs [n]    Last <n> lines of this container's own log (default 50)
  tra-about       Project name, version, and license
  tra-version     Project version plus OS/kernel/ttyd versions
  tra-help        This list

Standard tools already installed and ready to use directly:
  ping, traceroute, curl, wget, git, nano, vim, htop, jq, zip, unzip, ssh
EOF
