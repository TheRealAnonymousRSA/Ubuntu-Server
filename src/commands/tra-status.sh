#!/usr/bin/env bash
#
# tra-status
#
# Quick operational snapshot: system info, who is logged in, whether ttyd
# and the tmux session are actually running, and the healthcheck result.

set -uo pipefail

echo "=== TheRealAnonymousRSA VPS - status ==="
/opt/tra/system/sysinfo.sh
echo
echo "Logged in as   : $(whoami)"

if pgrep -x ttyd >/dev/null 2>&1; then
    pid="$(pgrep -x ttyd | head -n1)"
    echo "ttyd process   : running (pid ${pid})"
else
    echo "ttyd process   : not detected"
fi

if tmux has-session -t main 2>/dev/null; then
    windows="$(tmux list-windows -t main 2>/dev/null | wc -l)"
    echo "tmux session   : active (main, ${windows} window(s))"
else
    echo "tmux session   : not started yet"
fi

if /healthcheck.sh >/dev/null 2>&1; then
    echo "Health         : OK"
else
    echo "Health         : FAILING (run 'tra-logs' or check 'docker logs' for details)"
fi
