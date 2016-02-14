if [ $USER = root ]; then
    PROMPT="%F{red}%n%f@%F{blue}%m%f ! "
else
    PROMPT="%F{green}%n%f@%F{blue}%m%f ❯ " # `diti@Iceberg ❯ `
fi
RPROMPT="%~"                           # `~/proj`
