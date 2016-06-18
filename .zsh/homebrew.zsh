if command_exists 'brew'; then

    # If we don’t have root rights, use our own Homebrew install on $HOME
    if [ ! -w "/Library/Caches/Homebrew" ]; then
        BREW_PREFIX="$HOME/.brew"
        export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --binarydir=${BREW_PREFIX}/bin --caskroom=${BREW_PREFIX}/Caskroom"
        mkdir -p "$HOME/Library/Caches/Homebrew" && export HOMEBREW_CACHE=$_
    fi

    # Setup our own local Homebrew install if needed
    #if [ ! -d "$BREW_PREFIX" ]; then
    #    test -f /usr/local/bin/brew && $_ update && source ~/.zshrc
    #fi


    # Ensure $BREW_PREFIX is set
    : ${BREW_PREFIX:=$(brew --prefix)}

    # Use Homebrew’s binaries instead of the system’s
    export PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}

fi
