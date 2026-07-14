#!/usr/bin/env bash
#
# tra-update
#
# Updates the package index and upgrades installed packages.

set -euo pipefail

echo "Updating package lists..."
sudo apt-get update

echo "Upgrading installed packages..."
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

echo "Done."
