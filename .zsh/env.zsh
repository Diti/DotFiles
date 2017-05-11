export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/.composer/vendor/bin:$PATH

command_exists 'brew' && export BREW_PREFIX=$(brew --prefix)
command_exists 'go' && export PATH=$(go env GOPATH)/bin:$PATH
command_exists 'ocaml' && export OCAMLPARAM='w=A,_'

if command_exists 'vim'; then
	export EDITOR=vim
	export USE_EDITOR=$EDITOR
	export VISUAL=$EDITOR
fi
