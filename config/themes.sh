#!/usr/bin/env bash
#
# config/themes.sh
#
# Defines the named terminal color presets available via TERMINAL_THEME.
# Each theme is an xterm.js theme object, passed to ttyd via its
# documented `-t theme=<json>` client option (see ttyd wiki: Client
# Options). This is the officially supported way to configure terminal
# colors - it does not require touching ttyd's own frontend code at all.
#
# Usage:
#   themes.sh --has <name>    -> exit 0 if <name> is a known theme, else 1
#   themes.sh --json <name>   -> print the theme's JSON object
#   themes.sh --list          -> print all known theme names, one per line

set -euo pipefail

theme_dark='{"background":"#0d1117","foreground":"#c9d1d9","cursor":"#58a6ff","selectionBackground":"#264f78","black":"#484f58","red":"#ff7b72","green":"#3fb950","yellow":"#d29922","blue":"#58a6ff","magenta":"#bc8cff","cyan":"#39c5cf","white":"#b1bac4"}'

theme_light='{"background":"#ffffff","foreground":"#24292f","cursor":"#0969da","selectionBackground":"#b6e3ff","black":"#24292f","red":"#cf222e","green":"#116329","yellow":"#4d2d00","blue":"#0969da","magenta":"#8250df","cyan":"#1b7c83","white":"#6e7781"}'

theme_solarized='{"background":"#002b36","foreground":"#839496","cursor":"#93a1a1","selectionBackground":"#073642","black":"#073642","red":"#dc322f","green":"#859900","yellow":"#b58900","blue":"#268bd2","magenta":"#d33682","cyan":"#2aa198","white":"#eee8d5"}'

theme_dracula='{"background":"#282a36","foreground":"#f8f8f2","cursor":"#f8f8f0","selectionBackground":"#44475a","black":"#21222c","red":"#ff5555","green":"#50fa7b","yellow":"#f1fa8c","blue":"#bd93f9","magenta":"#ff79c6","cyan":"#8be9fd","white":"#f8f8f2"}'

_theme_var() {
    case "$1" in
        dark) echo "${theme_dark}" ;;
        light) echo "${theme_light}" ;;
        solarized) echo "${theme_solarized}" ;;
        dracula) echo "${theme_dracula}" ;;
        *) return 1 ;;
    esac
}

case "${1:-}" in
    --has)
        _theme_var "${2:-}" >/dev/null 2>&1
        exit $?
        ;;
    --json)
        _theme_var "${2:-}" || { echo "unknown theme: ${2:-}" >&2; exit 1; }
        ;;
    --list)
        echo "dark"
        echo "light"
        echo "solarized"
        echo "dracula"
        ;;
    *)
        echo "Usage: themes.sh --has <name> | --json <name> | --list" >&2
        exit 1
        ;;
esac
