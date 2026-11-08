#!/usr/bin/env bash
set -euo pipefail

terms=("${TERM:-xterm-256color}" xterm-256color screen-256color tmux-256color xterm-ghostty)

for t in $(printf '%s\n' "${terms[@]}" | sort -u); do
  infocmp -x "$t" >/dev/null 2>&1 || continue
  if infocmp -x "$t" 2>/dev/null | grep -q 'Smulx'; then
    echo "skip   $t (Smulx already set)"
    continue
  fi
  tmp="$(mktemp)"
  { infocmp -x "$t"; printf '\tSmulx=\\E[4:%%p1%%dm,\n'; } > "$tmp"
  tic -x "$tmp"
  rm -f "$tmp"
  echo "added  $t"
done

if command -v tmux >/dev/null 2>&1; then
  conf="$HOME/.config/tmux/tmux.conf"
  [ -f "$conf" ] || conf="$HOME/.tmux.conf"
  if [ -f "$conf" ] && grep -qE 'Smulx|usstyle' "$conf"; then
    echo "skip   $conf (undercurl already configured)"
  else
    cat >> "$conf" <<'TMUX'
set -g default-terminal "screen-256color"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
TMUX
    echo "added  $conf"
  fi
fi

printf '\e[4:3mundercurl\e[0m  <- 波線なら成功\n'
