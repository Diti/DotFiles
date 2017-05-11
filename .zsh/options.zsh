# FIXME Vim is better :)
bindkey -e

#autoload -U compinit && compinit
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
