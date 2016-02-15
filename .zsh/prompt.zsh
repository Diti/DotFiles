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
