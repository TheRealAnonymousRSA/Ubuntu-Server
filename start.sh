#!/usr/bin/env bash
#
# start.sh
#
# Kept as a top-level file (same path as v0.1) for compatibility with
# existing deployments that reference it directly. All of the actual
# launch logic now lives in src/terminal/launch.sh as part of the v0.5
# modular refactor - this file just execs straight into it.

set -euo pipefail

exec /opt/tra/terminal/launch.sh
