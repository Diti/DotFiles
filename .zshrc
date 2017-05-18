#!/usr/bin/zsh

command_exists() { type "$1" &>/dev/null; }

# Set more understandable OS names

case "$OSTYPE" in
  "darwin"*) DT_OS="Mac" ;;
  "linux"*)  DT_OS="Linux" ;;
  *)         echo "Some settings in $0 may not work; OS unsupported." >&2
esac


# Source all *.zsh files found in ~/.zsh/

if [ -d "$HOME/.zsh/" ]; then
  for file in $HOME/.zsh/**/[^(env)]*.zsh; do
    [ -e "$file" ] && source "$file" || echo "Error sourcing file '$file'" >&2
  done;
  source $HOME/.zsh/env.zsh
fi
