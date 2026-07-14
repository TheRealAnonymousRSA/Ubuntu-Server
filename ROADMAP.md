# Roadmap

This reflects the intended direction of the project. Scope and order can
shift as earlier milestones land and reveal what the next one actually
needs.

## v0.5 Beta (current)
- Modular `src/` architecture
- `tini` + `tmux` for reliable startup, signal handling, and session
  reconnect
- Structured logging, dependency verification, environment validation
- Terminal themes, custom title
- `tra-*` command set
- One-command package installers

## v0.6 Beta
- File manager (browse, rename, move, delete within the user's home
  directory)
- Upload / download through the browser
- Archive manager (zip/unzip a folder from the UI, not just the CLI)

## v0.7 Beta
- Multi-user accounts (more than one login identity per instance)
- Per-user permissions
- Authentication improvements (e.g. token-based sessions alongside Basic
  Auth)

## v0.8 Beta
- Web admin panel (a real UI, not just `tra-*` CLI commands, for
  managing the instance)
- Application manager (browse/install/remove common tools from the UI)
- Container management, where the host environment supports it (this is
  explicitly out of scope for the default image, which does not mount
  the Docker socket - see README > Security notes; this would need an
  opt-in, clearly-documented configuration)

## v0.9 RC
- Plugin system (a defined extension point for third-party `tra-*`-style
  commands)
- API (a way to drive the instance programmatically, not just through
  the terminal)
- Automatic backups (of the user's home directory / configuration)
- Performance optimization pass across the whole stack

## v1.0 Stable
- Stable release
- Complete documentation
- Installer (a guided setup path for self-hosting, beyond `docker
  compose up`)
- Automatic updates
- Public release
