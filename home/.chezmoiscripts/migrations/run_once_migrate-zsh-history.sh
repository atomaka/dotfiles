#!/usr/bin/env bash

set -euo pipefail

old="$HOME/.zsh_history"
new="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"

if [[ -f "$old" ]]; then
  mkdir -p "$(dirname "$new")"
  if [[ -f "$new" ]]; then
    cat "$new" "$old" > "${new}.merged"
    mv "${new}.merged" "$new"
  else
    mv "$old" "$new"
  fi
  rm -f "$old"
fi
