#!/usr/bin/env bash
#
# src/core/user-setup.sh <username> <password> <sudo_nopasswd>
#
# Idempotently ensures the given Linux user exists, has the given password,
# is a member of the sudo group, and has a validated sudoers.d entry.

set -euo pipefail

# shellcheck source=src/core/logging.sh
source /opt/tra/core/logging.sh

if [ "$#" -lt 2 ]; then
    log_error "Usage: user-setup.sh <username> <password> [sudo_nopasswd:true|false]"
    exit 1
fi

username="$1"
password="$2"
sudo_nopasswd="${3:-true}"

if [[ ! "${username}" =~ ^[a-z_][a-z0-9_-]{0,31}$ ]]; then
    log_error "'${username}' is not a valid Linux username"
    exit 1
fi

if ! id -u "${username}" >/dev/null 2>&1; then
    log_info "Creating user '${username}'"
    useradd --create-home --shell /bin/bash "${username}"
else
    log_info "User '${username}' already exists, updating credentials"
fi

echo "${username}:${password}" | chpasswd

usermod -aG sudo "${username}"

mkdir -p /etc/sudoers.d
chmod 0750 /etc/sudoers.d

sudoers_file="/etc/sudoers.d/90-${username}"
if [ "${sudo_nopasswd}" = "true" ]; then
    echo "${username} ALL=(ALL) NOPASSWD:ALL" > "${sudoers_file}"
else
    echo "${username} ALL=(ALL) ALL" > "${sudoers_file}"
fi
chmod 0440 "${sudoers_file}"

# Validate the sudoers fragment before trusting it; a malformed file here
# would silently break sudo for everyone.
visudo -cf "${sudoers_file}" >/dev/null

log_info "'${username}' is ready (sudo NOPASSWD: ${sudo_nopasswd})"
