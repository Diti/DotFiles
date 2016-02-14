set -o ALL_EXPORT

LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

command_exists 'brew' && BREW_PREFIX=$(brew --prefix)

if command_exists 'vim'; then
	EDITOR=vim
	USE_EDITOR=$EDITOR
	VISUAL=$EDITOR
fi

set +o ALL_EXPORT
