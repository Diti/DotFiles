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
  *)         printf "Some settings in ~/.zshrc may not work; OS unsupported.\n" 1>&2
esac

# Do we have Homebrew?
# Return 0 if yes ("no error"), 1 if no.
is_brew_installed() {
  if [[ "$DT_OS" == "Mac" ]]; then
    if type "brew" >/dev/null; then
      BREW_PREFIX="$(brew --cellar)/.." # Needed because of school 42’s local Homebrew installation
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

# ********************* #
#                       #
#    Package updates    #
#                       #
# ********************* #
# Put `brew update` in `crontab` for this check to be reliable
if is_brew_installed; then
  outdated=$(brew outdated)
  if [ -n "$outdated" ]; then
    echo 'Homebrew has some outdated packages:' 1>&2
    (echo $outdated | sed 's/^/• /') 1>&2
    echo 'You may wish to `brew upgrade --all`.' 1>&2
  fi
fi

# ********************************** #
#                                    #
#    Public environment variables    #
#                                    #
# ********************************** #
if type "vim" >/dev/null; then
  export EDITOR=vim
  export USE_EDITOR=$EDITOR
  export VISUAL=$EDITOR
fi

export GPG_TTY=$(tty)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [[ "$DT_OS" == "Mac" ]]; then
  # Environment variables specific to my home computer
  if [[ "$HOST" == "Iceberg" ]]; then
    # Boot2docker
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=${HOME}/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1

    # Android development
    export ANDROID_HOME=${HOME}/Library/Android/sdk
    export GRADLE_HOME=/usr/local/opt/gradle/libexec/
    export PATH=${JAVA_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:/opt/local/bin:/opt/local/sbin:$PATH
  fi

  if is_brew_installed; then
    # Use Homebrew binaries in priority
    export PATH="${BREW_PREFIX}/bin:${PATH}"

    if brew list -1 | grep -q "^zsh-completions\$"; then
      fpath=(${BREW_PREFIX}/share/zsh-completions $fpath)
    fi
    # The `zsh-syntax-highlighting` sourcing must “stay at the end”
    if brew list -1 | grep -q "^zsh-syntax-highlighting\$"; then
      . ${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
  fi
fi

# *********************************** #
#                                     #
#    Private environment variables    #
#                                     #
# *********************************** #
# Store them in an sourceable `#!/bin/sh` file
if [ -f "${HOME}/.private" ]; then
  . "${HOME}/.private"
fi

# ************************* #
#                           #
#    GnuPG’s `gpg-agent`    #
#                           #
# ************************* #
if type "gpg-agent" >/dev/null; then
  gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info" >/dev/null
fi

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
  export SSH_AGENT_PID
fi

# *************************************** #
#                                         #
#    `less` pager’s syntax highighting    #
#                                         #
# *************************************** #
if [[ "$DT_OS" == "Linux" ]]; then
    local hlfile="/usr/share/source-highlight/src-hilite-lesspipe.sh"
elif [[ "$DT_OS" == "Mac" ]]; then
  if is_brew_installed; then
         if brew list -1 | grep -q "^source-highlight\$"; then
             local hlfile="${BREW_PREFIX}/bin/src-hilite-lesspipe.sh"
         fi
     fi
 else
     # No alternative yet
fi
if [ -f "$hlfile" ]; then
    export LESSOPEN="| $hlfile %s"
    export LESS=' -R '
fi

# ****************** #
#                    #
#    ZSH settings    #
#                    #
# ****************** #
# Emacs keybindings
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

# ************ #
#              #
#    Prompt    #
#              #
# ************ #
PROMPT="%F{green}%n%f@%F{blue}%m%f $ " # `diti@Iceberg $ `
RPROMPT="%~"                           # `~/proj`

# ********************* #
#                       #
#    Command aliases    #
#                       #
# ********************* #
alias ls='ls -lh'
alias reload='. ~/.zshrc'

# ************ #
#              #
#    Extras    #
#              #
# ************ #
umask 0027 # -rw-r----- and drwxr-x--- permissions by default. Group’s X needed for ACLs
