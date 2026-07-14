#!/usr/bin/env bash
#
# tra-storage
#
# Disk usage analyzer: filesystem overview plus the largest directories
# under the current user's home, so it's easy to see what's eating space.

set -uo pipefail

echo "=== Filesystems ==="
df -h

echo
echo "=== Largest directories under ${HOME} ==="
du -h --max-depth=1 "${HOME}" 2>/dev/null | sort -rh | head -n 15

echo
echo "Tip: 'du -h --max-depth=1 <dir> | sort -rh' drills into any other directory."
