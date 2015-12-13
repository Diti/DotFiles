#!/bin/zsh
# **************************************************************************** #
#                                                                              #
#                                                 [E-mail]            The      #
#    ~/.zshrc                                      kra@diti.me      name's>    #
#                                                                 Diti. I      #
#    By: Diti Torterat <kra@diti.me>              [PGP]          love pen-     #
#                                                  CD42FF00     guins \and     #
#    Created: 2015/07/14 15:55:27 by Diti                       owls. /`-'     #
#                                                             ,;;  `#\.        #
#                                                                              #
# **************************************************************************** #

# Set more understandable OS names
case "$OSTYPE" in
  "darwin"*) DT_OS="Mac" ;;
  "linux"*)  DT_OS="Linux" ;;
  *)         echo 'Some settings in ~/.zshrc may not work; OS unsupported.' 1>&2
esac

# Do we have Homebrew?
# For use in scripts, 0 if yes ("no error"), 1 if no.
if [ "$DT_OS" = "Mac" ]; then
  if type "brew" >/dev/null; then
    BREW_INSTALLED=true
  else
    BREW_INSTALLED=false
  fi
else
  BREW_INSTALLED=false
fi

# The following fix is needed because of school 42’s local Homebrew installation
if [[ "$HOST" =~ ".*42.fr$" ]]; then
  BREW_PREFIX="$HOME/.brew"

  # If not using our local brew, init the school’s one and reload the path
  if [ ! -d "$HOME/.brew" ]; then
    /usr/local/bin/brew update && . ~/.zshrc
  fi

  if [ ! -d "$HOME/Library/Caches/Homebrew" ]; then
    mkdir -p "$HOME/Library/Caches/Homebrew" && export HOMEBREW_CACHE=$_
  fi

  alias brew="${BREW_PREFIX}/bin/brew"
  export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --binarydir=${BREW_PREFIX}/bin --caskroom=${BREW_PREFIX}/Caskroom"
fi

# ┌────────────────────────────┐
# │                            │
# │      Package updates       │
# │                            │
# └────────────────────────────┘
# Put `brew update` in `crontab` for this check to be reliable
if [ "$BREW_INSTALLED" = true ]; then
  outdated=$(brew outdated)

  if [ -n "$outdated" ]; then
    echo '[i] Some Homebrew packages should be upgraded:' 1>&2
    (echo "$outdated" | sed 's/^/• /') 1>&2
  fi

fi

# ┌────────────────────────────┐
# │                            │
# │   Environment variables    │
# │                            │
# └────────────────────────────┘
if type rbenv >/dev/null; then eval "$(rbenv init -)"; fi
# Most variables are set in ~/.zshenv, automatically loaded at launch.
# We only export her if they are truly needed, here.
if [ "$DT_OS" = "Mac" ]; then
  # Environment variables specific to my home computer
  if [ "$HOST" = "Iceberg" ]; then
    # Boot2docker
    export $DOCKER_HOST
    export $DOCKER_CERT_PATH
    export $DOCKER_TLS_VERIFY

    # Android development
    export PATH=${ANDROID_PATH}:$PATH
  fi

  if [ "$BREW_INSTALLED" = true ]; then
    # Use Homebrew binaries in priority
    export PATH="$HOME/.brew/bin:$HOME/.composer/vendor/bin:${PATH_WITH_BREW_FIRST}"

    # The following are not really environment variables, but heh!

    if brew list -1 | grep -q "^zsh-completions\$"; then
      fpath=(${BREW_PREFIX}/share/zsh-completions $fpath)
    fi
    # The `zsh-syntax-highlighting` sourcing must “stay at the end”
    if brew list -1 | grep -q "^zsh-syntax-highlighting\$" && [ -f "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
      . "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
  fi
fi

# ┌────────────────────────────┐
# │                            │
# │    GnuPG’s `gpg-agent`     │
# │                            │
# └────────────────────────────┘
if type "gpg-agent" >/dev/null; then
  gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info" >/dev/null 2>&1
fi

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
  export SSH_AGENT_PID
fi

# ┌────────────────────────────┐
# │                            │
# │        `less` pager        │
# │    syntax highlighting     │
# │                            │
# └────────────────────────────┘
if [ "$DT_OS" = "Linux" ]; then
    local hlfile="/usr/share/source-highlight/src-hilite-lesspipe.sh"
elif [ "$DT_OS" = "Mac" ]; then
  if [ "$BREW_INSTALLED" = true ]; then
         if brew list -1 | grep -q "^source-highlight\$"; then
             local hlfile="${BREW_PREFIX}/bin/src-hilite-lesspipe.sh"
         fi
     fi
 else
     true # No alternative yet
fi
if [ -f "$hlfile" ]; then
    export LESSOPEN="| $hlfile %s"
    export LESS=' -R '
fi

# ┌────────────────────────────┐
# │                            │
# │        ZSH settings        │
# │                            │
# └────────────────────────────┘
# FIXME Vim is better :)
bindkey -e

autoload -U compinit && compinit
autoload -U promptinit && promptinit

# Wait 10 seconds before a rm-*-something...
setopt RM_STAR_WAIT

HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Disable `!` history commands; enables us to use "!" in commands without escaping it
setopt no_bang_hist
# Enable the use of `# <cmd>`, commented lines
setopt interactivecomments

# Permits the use of the ^ operator for exclusion in globbing
# Like so: `grep -u 'some text that won’t be searched in libft' (**|^~libft)/*.{c,h}`
setopt extendedglob

setopt autocd

# ┌────────────────────────────┐
# │                            │
# │           Prompt           │
# │                            │
# └────────────────────────────┘
PROMPT="%F{green}%n%f@%F{blue}%m%f ❯ " # `diti@Iceberg ❯ `
RPROMPT="%~"                           # `~/proj`

# ┌────────────────────────────┐
# │                            │
# │      Custom functions      │
# │                            │
# └────────────────────────────┘
# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# ┌────────────────────────────┐
# │                            │
# │      Command aliases       │
# │                            │
# └────────────────────────────┘
alias cask='brew cask'
alias gpg='gpg2'
if type "exa" >/dev/null; then
  alias ls='exa'
  alias ll='exa --git --long'
else
  alias ls='ls -hFG'
  alias ll='ls -l'
fi
alias reload='. ~/.zshrc'

# ┌────────────────────────────┐
# │                            │
# │           Extras           │
# │                            │
# └────────────────────────────┘
umask 0027 # -rw-r----- and drwxr-x--- permissions by default. Group’s X needed for ACLs

zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.o' # Ignore *.o files to open with Vim
