# History options taken from here:
# https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps

HISTSIZE=5000
HISTFILESIZE=10000

# Append instead of overwriting the history file
shopt -s histappend

# Add commands to history immediately
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# Finally, load the default configuration
[[ -s ${HOME}/.profile ]] && source ${HOME}/.profile
