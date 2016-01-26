if [[ "$HOST" =~ ".*42.fr$" ]]; then

	export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --binarydir=${BREW_PREFIX}/bin --caskroom=${BREW_PREFIX}/Caskroom"

	# If not using our local brew, init the school’s one and reload the path
	if [ ! -d "$HOME/.brew" ]; then
		/usr/local/bin/brew update && source ~/.zshrc
	fi

	# We may not have the rights on /Library/Caches, so we use our user’s
	if [ ! -d "$HOME/Library/Caches/Homebrew" ]; then
		mkdir -p "$HOME/Library/Caches/Homebrew" && export HOMEBREW_CACHE=$_
	fi

fi

# Use Homebrew’s binaries instead of the system’s
export PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}
