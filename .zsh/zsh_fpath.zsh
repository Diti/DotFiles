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
