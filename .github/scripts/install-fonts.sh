#!/usr/bin/env bash
# Install the fonts the Typst formats need on a Linux CI runner.
#
# Shared by the dev repository (assignment PDFs) and the public repository
# (the book PDF), so both produce identical output.
#
#   Fonts go to ~/.local/share/fonts, so no sudo or apt is needed.
set -euo pipefail

# CJK: "Noto Serif JP" / "Noto Sans JP" (see _quarto.yml and the
# jsbook/jsarticle Typst templates). Take the static Japanese-subset OTFs from
# the official noto-cjk releases (~60 MB) rather than apt's fonts-noto-cjk,
# which ships every CJK language. Google Fonts only ships variable fonts,
# from which Typst cannot pick weights. Unlike JuliaMono, a failure is fatal.
install_noto_jp() {
  local dir tmp
  dir="$HOME/.local/share/fonts/NotoJP"
  tmp=$(mktemp -d)
  mkdir -p "$dir"
  curl -fsSL -o "$tmp/serif.zip" \
    https://github.com/notofonts/noto-cjk/releases/download/Serif2.003/12_NotoSerifJP.zip
  curl -fsSL -o "$tmp/sans.zip" \
    https://github.com/notofonts/noto-cjk/releases/download/Sans2.004/16_NotoSansJP.zip
  unzip -q -o -j "$tmp/serif.zip" '*.otf' -d "$dir"
  unzip -q -o -j "$tmp/sans.zip" '*.otf' -d "$dir"
  rm -rf "$tmp"
}
install_noto_jp

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
fc-list : family | tr ',' '\n' | grep -iE 'noto (serif|sans) jp|juliamono' | sort -u
