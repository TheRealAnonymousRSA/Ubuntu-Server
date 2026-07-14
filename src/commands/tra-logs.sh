#!/usr/bin/env bash
#
# tra-logs [n]
#
# Shows the last <n> (default 50) lines of this container's own
# structured log (written by every core script via src/core/logging.sh).
# A minimal container has no syslog/journald running, so this file is
# the source of truth for what happened during startup and since.

set -uo pipefail

lines="${1:-50}"
log_file="/var/log/tra/system.log"

if [ ! -r "${log_file}" ]; then
    echo "No log file found yet at ${log_file}."
    exit 0
fi

echo "=== Last ${lines} line(s) of ${log_file} ==="
tail -n "${lines}" "${log_file}"
