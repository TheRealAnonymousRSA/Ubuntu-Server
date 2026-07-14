#!/usr/bin/env bash
#
# src/system/sysinfo.sh
#
# Prints a snapshot of system information. Shared by the banner, tra-status,
# and tra-version commands so the "what does the box look like right now"
# logic lives in exactly one place.

set -uo pipefail

os_pretty="Unknown"
if [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
    os_pretty="$( . /etc/os-release && echo "${PRETTY_NAME:-Unknown}" )"
fi

kernel="$(uname -r 2>/dev/null || echo unknown)"

cpu_model="$(awk -F': ' '/model name/ {print $2; exit}' /proc/cpuinfo 2>/dev/null)"
[ -z "${cpu_model}" ] && cpu_model="Unknown"
cpu_cores="$(nproc 2>/dev/null || echo unknown)"

mem_total_kb="$(awk '/MemTotal/ {print $2}' /proc/meminfo 2>/dev/null || echo 0)"
mem_avail_kb="$(awk '/MemAvailable/ {print $2}' /proc/meminfo 2>/dev/null || echo 0)"
mem_total_mb=$(( mem_total_kb / 1024 ))
mem_avail_mb=$(( mem_avail_kb / 1024 ))

disk_line="$(df -h / 2>/dev/null | awk 'NR==2 {print $3 " used / " $2 " total (" $5 " full)"}')"
[ -z "${disk_line}" ] && disk_line="Unknown"

load_avg="$(cut -d' ' -f1-3 /proc/loadavg 2>/dev/null || echo unknown)"

hostname_val="$(hostname 2>/dev/null || echo unknown)"
ip_addr="$(hostname -I 2>/dev/null | awk '{print $1}')"
[ -z "${ip_addr}" ] && ip_addr="Unknown"

# Rough interface count / default route, for the one-line network summary
default_iface="$(ip route show default 2>/dev/null | awk '/default/ {print $5; exit}')"
[ -z "${default_iface}" ] && default_iface="Unknown"

ttyd_version="$(ttyd --version 2>/dev/null | head -n1)"
[ -z "${ttyd_version}" ] && ttyd_version="Unknown"

# The Docker *engine* running on the host is deliberately not queryable from
# inside the container. Doing that would require mounting the host's
# /var/run/docker.sock, which hands anyone who can log into this terminal
# root-equivalent control of the host - not an acceptable trade-off for a
# box whose whole point is a secure login. See README > Security notes.
docker_engine="not exposed inside the container (by design, see README)"

start_file="/var/run/tra-start-time"
if [ -r "${start_file}" ]; then
    start_epoch="$(cat "${start_file}")"
    now_epoch="$(date +%s)"
    uptime_secs=$(( now_epoch - start_epoch ))
    uptime_human="$(printf '%dd %dh %dm' $((uptime_secs/86400)) $(((uptime_secs%86400)/3600)) $(((uptime_secs%3600)/60)))"
else
    uptime_human="unknown"
fi

cat <<EOF
  Ubuntu        : ${os_pretty}
  Kernel        : ${kernel}
  Hostname      : ${hostname_val}
  CPU           : ${cpu_model} (${cpu_cores} cores)
  RAM           : ${mem_avail_mb} MB available / ${mem_total_mb} MB total
  Disk (/)      : ${disk_line}
  Load          : ${load_avg}
  Network       : ${ip_addr} (via ${default_iface})
  Uptime        : ${uptime_human} (this container session)
  Docker Engine : ${docker_engine}
  ttyd          : ${ttyd_version}
EOF
