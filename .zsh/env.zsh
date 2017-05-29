export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

test -d /usr/local/go/bin && export PATH=$_:$PATH

export PATH=$HOME/.composer/vendor/bin:$PATH

command_exists 'brew' && export BREW_PREFIX=$(brew --prefix)
command_exists 'go' && export PATH=$(go env GOPATH)/bin:$PATH

if command_exists 'gpg' || command_exists 'gpg2'; then
    export GPG_TTY=$(tty)
    eval $(gpg-agent --enable-ssh-support --daemon 2>/dev/null)
    gpg-connect-agent updatestartuptty /bye >/dev/null
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

command_exists 'ocaml' && export OCAMLPARAM='w=A,_'

if command_exists 'vim'; then
	export EDITOR=vim
	export USE_EDITOR=$EDITOR
	export VISUAL=$EDITOR
fi
