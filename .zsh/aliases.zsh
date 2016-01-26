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

alias history='fc -il 1'

alias reload='source $HOME/.zshrc'
