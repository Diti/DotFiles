# ┌──────────────────────────────────────┐
# │         Aliases & functions          │
# └──────────────────────────────────────┘

command_exists() { type "$1" &>/dev/null; }

if command_exists 'exa'; then
    alias ls='exa'
    alias la='exa --all'
    alias ll='exa --git --long'
    alias lla='exa --all --git --long'
else
    alias ls='ls -hFG'
    alias la='ls -ahFG'
    alias ll='ls -hFGl'
    alias lla='ls -ahFGl'
fi

command_exists 'rlwrap' && alias ocaml='rlwrap ocaml'

alias history='fc -il 1'
alias path='echo "$PATH" | tr : \\n'
alias reload='. $HOME/.zshrc'

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

mkcd() {
    mkdir $1 && cd $1
}

pwgen() {
    perl -pe 'tr/A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+=//dc;' </dev/urandom | head -c ${1:-32};
    echo
}

# ┌──────────────────────────────────────┐
# │              Completion              │
# └──────────────────────────────────────┘

zstyle ':completion:*:*:ocamlopt:*' file-patterns '*(-/):directories *.ml'
zstyle ':completion:*:*:vi*:*' file-sort modification
zstyle ':completion:*:*:vi*:*:*files' ignored-patterns '*.(class|o)'

# ┌──────────────────────────────────────┐
# │             Environment              │
# └──────────────────────────────────────┘

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

command_exists 'go' && export PATH=$(go env GOPATH)/bin:$PATH
command_exists 'ocaml' && export OCAMLPARAM='w=A,_'
command_exists 'vim' && export EDITOR=$_ USE_EDITOR=$_ VISUAL=$_
command_exists 'nvim' && export EDITOR=$_ USE_EDITOR=$_ VISUAL=$_

test -d $HOME/.cargo/env && source $_
test -d $HOME/.composer/vendor/bin && export PATH=$_:$PATH

if command_exists 'gpg' || command_exists 'gpg2'; then
    export GPG_TTY=$(tty)
    eval $(gpg-agent --enable-ssh-support --daemon 2>/dev/null)
    gpg-connect-agent updatestartuptty /bye >/dev/null
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# ┌──────────────────────────────────────┐
# │             School (42)              │
# └──────────────────────────────────────┘

if [[ "$HOST" == *42.fr ]]; then

    if test -d /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man; then
        export MANPATH="$_:$MANPATH"
    fi

    if command_exists 'brew'; then
        BREW_PREFIX="$HOME"/.brew

        # If we don’t have root rights, use our own Homebrew install on $HOME
        if [ ! -w "/Library/Caches/Homebrew" ]; then
            export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
            mkdir -p "$HOME/Library/Caches/Homebrew" && export HOMEBREW_CACHE=$_
        fi

        # Use Homebrew’s binaries instead of the system’s
        export PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}
    fi

fi

# Ensure $BREW_PREFIX is set
if command_exists 'brew'; then
    ${BREW_PREFIX:=$(brew --prefix)}
fi

# ┌──────────────────────────────────────┐
# │             ZSH options              │
# └──────────────────────────────────────┘

autoload -U compinit && compinit -u
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
autoload -U colors && colors

PROMPT_SYMBOL=$(print -P "%(!.#.$)")

if [[ "$PROMPT_SYMBOL" == '#' ]]; then
    PROMPT_USERNAME="%F{red}%n%f"
else
    PROMPT_USERNAME="%F{green}%n%f"
fi

PROMPT_HOSTNAME="%F{blue}%m%f"


PROMPT="${PROMPT_USERNAME}@${PROMPT_HOSTNAME} ${PROMPT_SYMBOL} "
RPROMPT="%~"
if command_exists 'brew'; then
    if brew list -1 | grep -q "^zsh-completions\$"; then
        fpath=(${BREW_PREFIX}/share/zsh-completions $fpath)
    fi

    local hlfile="${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    if brew list -1 | grep -q "^zsh-syntax-highlighting\$" && [ -f "$hlfile" ]; then
        source "$hlfile"
    fi
fi

test -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && source $_
