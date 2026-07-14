#!/usr/bin/env bash
#
# tra-install <name> [<name>...]
#
# Installs packages. Recognized shortcuts map to the right underlying
# apt package(s); anything else is passed straight through to
# `apt-get install`, so this also works as a general-purpose installer.
#
# Shortcuts: node, python, git, docker, curl, ffmpeg, nano, vim, build-tools

set -euo pipefail

if [ "$#" -eq 0 ]; then
    cat <<'EOF'
Usage: tra-install <name> [<name>...]

Shortcuts:
  node          Node.js + npm
  python        Python 3 + pip + venv
  git           Git
  docker        Docker CLI (docker.io package; the bundled daemon is not
                usable inside this container without mounting the host's
                Docker socket, which this image deliberately does not do -
                see README > Security notes)
  curl          curl
  ffmpeg        FFmpeg
  nano          Nano
  vim           Vim
  build-tools   build-essential (gcc, make, etc.)

Anything else is passed straight to `apt-get install -y <name>`.
EOF
    exit 1
fi

declare -A SHORTCUTS=(
    [node]="nodejs npm"
    [python]="python3 python3-pip python3-venv"
    [git]="git"
    [docker]="docker.io"
    [curl]="curl"
    [ffmpeg]="ffmpeg"
    [nano]="nano"
    [vim]="vim"
    [build-tools]="build-essential"
)

packages=()
for name in "$@"; do
    if [ -n "${SHORTCUTS[${name}]:-}" ]; then
        # shellcheck disable=SC2206
        packages+=(${SHORTCUTS[${name}]})
    else
        packages+=("${name}")
    fi
done

echo "Installing: ${packages[*]}"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}"
echo "Done."
