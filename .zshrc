#!/usr/bin/zsh
# **************************************************************************** #
#                                                                              #
#                                                 [E-mail]            The      #
#    ~/.zshrc                                      kra@diti.me      name's>    #
#                                                                 Diti. I      #
#    By: Diti Torterat <kra@diti.me>              [PGP]          love pen-     #
#                                                  CD42FF00     guins \and     #
#    Created: 2016-01-17T20:02:42 by Diti                       owls. /`-'     #
#                                                             ,;;  `#\.        #
#                                                                              #
# **************************************************************************** #

command_exists() { type "$1" &>/dev/null; }

# Set more understandable OS names

case "$OSTYPE" in
  "darwin"*) DT_OS="Mac" ;;
  "linux"*)  DT_OS="Linux" ;;
  *)         echo "Some settings in $0 may not work; OS unsupported." >&2
esac


# Source all *.zsh files found in ~/.zsh/

if [ -d "$HOME/.zsh/" ]; then
  for file in $HOME/.zsh/**/*.zsh; do
    [ -e "$file" ] && source "$file" || echo "Error sourcing file '$file'" >&2
  done;
  source $HOME/.zsh/env.zsh
fi
