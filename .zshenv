#!/bin/zsh
# **************************************************************************** #
#                                                                              #
#                                                 [E-mail]            The      #
#    ~/.zshrc                                      kra@diti.me      name's>    #
#                                                                 Diti. I      #
#    By: Diti Torterat <kra@diti.me>              [PGP]          love pen-     #
#                                                  CD42FF00     guins \and     #
#    Created: 2015/07/29 19:03:47 by Diti                       owls. /`-'     #
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
  PATH="/usr/local/bin:$PATH"
  if type "brew" >/dev/null; then
    BREW_INSTALLED=true
  else
    BREW_INSTALLED=false
  fi
else
  BREW_INSTALLED=false
fi

BREW_PREFIX="$HOME/.brew"

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

ANDROID_HOME=${HOME}/Library/Android/sdk
GRADLE_HOME=/usr/local/opt/gradle/libexec/
ANDROID_PATH=${JAVA_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

PATH_WITH_BREW_FIRST="${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}" # FIXME Multiple PATH concat upon multiple reloads

# *********************************** #
#                                     #
#    Private environment variables    #
#                                     #
# *********************************** #
# Store them in an sourceable `#!/bin/sh` file
if [ -f "${HOME}/.env_private" ]; then
  . "${HOME}/.env_private"
fi
