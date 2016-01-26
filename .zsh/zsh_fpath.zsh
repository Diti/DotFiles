if command_exists 'brew'; then
	if brew list -1 | grep -q "^zsh-completions\$"; then
		fpath=(${BREW_PREFIX}/share/zsh-completions $fpath)
	fi
fi
