if command_exists 'brew' && [[ "$HOST" =~ ".*42.fr$" ]]; then

    export BREW_PREFIX="$HOME/.brew"

    export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --binarydir=${BREW_PREFIX}/bin --caskroom=${BREW_PREFIX}/Caskroom"

    # If not using our local brew, init the school’s one and reload the path
    if [ ! -d "$BREW_PREFIX" ]; then
        test -f /usr/local/bin/brew && $_ update && source ~/.zshrc
    fi

    # Use our own directories for Homebrew data
    local tmpDataDir="/tmp/${USER}-brew-$(date '+%Y%m%d')"

    mkdir -p ${tmpDataDir}/{cache,tmp}

    test -d "${tmpDataDir}/cache" && export HOMEBREW_CACHE=$_
    test -d "${tmpDataDir}/tmp" && export HOMEBREW_TEMP=$_

fi

# Use Homebrew’s binaries instead of the system’s
export PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}
