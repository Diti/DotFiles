set -o ALL_EXPORT

LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

if command_exists 'vim'; then
	EDITOR=vim
	USE_EDITOR=$EDITOR
	VISUAL=$EDITOR
fi

BREW_PREFIX=$(brew --prefix)

set +o ALL_EXPORT
