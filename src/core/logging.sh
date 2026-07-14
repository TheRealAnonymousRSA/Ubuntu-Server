#!/usr/bin/env bash
#
# src/core/logging.sh
#
# Shared logging functions. Sourced (not executed) by other scripts.
# Every log line goes to stdout (so `docker logs` captures it) AND to
# /var/log/tra/system.log (so the `tra-logs` command has real history to
# show, since a minimal container has no syslog/journald running).
#
# Usage (after sourcing):
#   log_info  "message"
#   log_warn  "message"
#   log_error "message"

TRA_LOG_DIR="/var/log/tra"
TRA_LOG_FILE="${TRA_LOG_DIR}/system.log"

_tra_log() {
    local level="$1"
    shift
    local msg="$*"
    local ts
    ts="$(date '+%Y-%m-%d %H:%M:%S')"
    local line="[${ts}] [${level}] ${msg}"

    if [ "${level}" = "ERROR" ]; then
        echo "${line}" >&2
    else
        echo "${line}"
    fi

    if [ -d "${TRA_LOG_DIR}" ] || mkdir -p "${TRA_LOG_DIR}" 2>/dev/null; then
        echo "${line}" >> "${TRA_LOG_FILE}" 2>/dev/null || true
    fi
}

log_info()  { _tra_log "INFO"  "$@"; }
log_warn()  { _tra_log "WARN"  "$@"; }
log_error() { _tra_log "ERROR" "$@"; }
