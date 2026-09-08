#!/usr/bin/env bash
# Install the fonts the Typst formats need on a Linux CI runner.
#
# Shared by the dev repository (assignment PDFs) and the public repository
# (the book PDF), so both produce identical output.
#
#   sudo-less apt is unavailable on some runners; this script assumes GitHub's
#   ubuntu-latest image, where `sudo apt-get` works without a password.
set -euo pipefail

# CJK: "Noto Serif CJK JP" / "Noto Sans CJK JP" (see _quarto.yml and the
# jsbook/jsarticle Typst templates).
sudo apt-get update -qq
sudo apt-get install -y -qq --no-install-recommends fonts-noto-cjk fonts-noto-cjk-extra

# Code font: JuliaMono is not packaged for Ubuntu, so take it from upstream.
# A failure here is not fatal: Typst falls back to another monospace face.
install_juliamono() {
  local url dir
  url=$(curl -fsSL https://api.github.com/repos/cormullion/juliamono/releases/latest |
    grep -o 'https://[^"]*JuliaMono-ttf\.tar\.gz' | head -1)
  [ -n "$url" ] || return 1
  dir="$HOME/.local/share/fonts/JuliaMono"
  mkdir -p "$dir"
  curl -fsSL "$url" | tar xz -C "$dir"
}
install_juliamono || echo "warning: JuliaMono not installed; code blocks fall back to another mono font" >&2

fc-cache -f > /dev/null
fc-list : family | tr ',' '\n' | grep -iE 'noto (serif|sans) cjk jp|juliamono' | sort -u
