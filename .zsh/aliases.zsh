alias cask='brew cask'

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

if command_exists 'rlwrap'; then
  alias ocaml='rlwrap ocaml'
fi

alias history='fc -il 1'
alias path='echo "$PATH" | tr : \\n'
alias reload='zcompile "$HOME"/.zshrc && zcompile "$HOME"/.zsh**/*.zsh && source $HOME/.zshrc'
