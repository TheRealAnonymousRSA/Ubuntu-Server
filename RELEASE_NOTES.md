# Release Notes - v0.5 Beta

**TheRealAnonymousRSA VPS v0.5 Beta** is a from-the-ground-up refactor of
the original ttyd browser terminal, aimed at making it feel like a
genuine small platform rather than a single Dockerfile: a modular
codebase, real session persistence, structured logging, and a proper
command set.

## Highlights

**Your session survives a dropped connection.** Every terminal
connection now runs inside a `tmux` session named `main`. Refresh the
tab, lose Wi-Fi for a minute, or open a second tab - you land back in
the same shell, with the same working directory and running processes,
not a fresh one.

**A real command set.** `tra-status`, `tra-network`, `tra-storage`,
`tra-ip`, `tra-speedtest`, `tra-logs`, and friends replace the smaller
v0.1 command list, all under one consistent `tra-` prefix so nothing
collides with standard Linux tools.

**One-command installs.** `tra-install node`, `tra-install python`,
`tra-install docker`, and similar shortcuts cover the tools people reach
for most; anything else falls through to `apt-get install` directly.

**Four terminal themes.** Set `TERMINAL_THEME` to `dark` (default),
`light`, `solarized`, or `dracula`.

**Startup you can trust.** `tini` runs as PID 1 for correct signal
handling and zombie reaping. A dependency-verification pass and
environment-variable validation run before anything else starts, with
clear warnings and safe fallbacks instead of confusing failures three
steps later.

**Everything logs somewhere.** Structured, timestamped log lines go to
both `docker logs` and a persistent `/var/log/tra/system.log`, readable
any time via `tra-logs`.

## Upgrading from v0.1

- `start.sh` and `entrypoint.sh` remain at the same repository paths, so
  existing `docker-compose.yml` / Dockerfile references keep working.
- New environment variable: `TERMINAL_THEME` (optional, defaults to
  `dark`).
- The `install` command from v0.1 is gone; use `tra-install` instead.
- If you had a named volume mounted at `/home/<username>`, it continues
  to work unchanged.

## Known limitations in this beta

- `tra-speedtest` is a lightweight approximation (a single-file download
  timing test against a public CDN), not a rigorous measurement.
- Typing into a terminal from a mobile on-screen keyboard is inherently
  more cumbersome than a physical keyboard - this is a general limitation
  of browser terminals, not something this release changes.
- Multi-user accounts, the file manager, and the admin panel are not yet
  implemented - see `ROADMAP.md`.
