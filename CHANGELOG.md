# Changelog

All notable changes to this project are documented here.
Format loosely follows [Keep a Changelog](https://keepachangelog.com/).

## [0.5.0-beta] - 2026-07-13

### Added
- Modular architecture under `src/`: `core/`, `terminal/`, `system/`,
  `commands/`, `branding/`, plus theme presets in `config/themes.sh`.
- `tini` as PID 1 for correct signal forwarding and zombie reaping.
- Persistent terminal sessions via `tmux` - reconnecting (a dropped
  websocket, a browser refresh, a new tab) reattaches to the same
  session instead of starting a fresh shell.
- Structured logging (`src/core/logging.sh`): every core script now logs
  timestamped, leveled lines to both stdout and `/var/log/tra/system.log`.
- Startup dependency verification and environment validation
  (`src/core/bootstrap.sh`), with safe fallbacks and loud warnings
  instead of silent misbehavior on bad config.
- Four selectable terminal color themes (`TERMINAL_THEME`: `dark`,
  `light`, `solarized`, `dracula`), applied via ttyd's own documented
  `-t theme=` client option.
- Custom, fixed browser tab title via ttyd's `-t titleFixed=` option.
- Eleven `tra-*` commands: `tra-status`, `tra-update`, `tra-install`,
  `tra-network`, `tra-storage`, `tra-ip`, `tra-speedtest`, `tra-logs`,
  `tra-about`, `tra-version`, `tra-help`.
- One-command installer shortcuts inside `tra-install` for Node.js,
  Python, Git, Docker CLI, curl, FFmpeg, Nano, Vim, and build tools.
- `ping` and `traceroute` now installed and usable directly (previously
  absent from the base image).
- `ROADMAP.md` and `RELEASE_NOTES.md`.

### Changed
- All commands renamed with a `tra-` prefix. This also removed the need
  for the v0.1 `install` shell-function workaround (see Removed) - every
  command is now a uniquely-named script, since nothing collides with an
  existing coreutils binary anymore.
- `healthcheck.sh` documents explicitly why an absent tmux session right
  after startup is normal (it's created lazily on first connection) and
  is not treated as a failure.
- `entrypoint.sh` now *sources* `bootstrap.sh` rather than executing it
  as a subprocess, so validated/corrected environment variables actually
  propagate to the rest of the startup chain.
- `start.sh` is now a thin two-line delegator to
  `src/terminal/launch.sh`, kept at the repository root so existing
  deployments that reference `start.sh` directly keep working unchanged.

### Removed
- The v0.1 `install` bash-function workaround (no longer needed - see
  Changed).
- The flat `scripts/` and `assets/` directories, superseded by `src/`.

### Fixed
- `ping` and `traceroute` are genuinely installed now; on v0.1 the
  `net-tools`/`iproute2` package set did not actually provide either
  binary, so `tra-network`'s advertised tip ("ping and traceroute are
  ready to use") would have been false without this fix.
- `user-setup.sh` now creates `/etc/sudoers.d` if missing before writing
  into it, instead of assuming it already exists.

## [0.1.0-beta] - 2026-07-13

- Initial release: ttyd browser terminal on Ubuntu 24.04, Docker +
  Docker Compose, GitHub Actions build/test workflow, `status` /
  `update` / `install` / `version` / `banner` / `health` commands,
  environment-variable-driven login with auto-generated password
  fallback.
