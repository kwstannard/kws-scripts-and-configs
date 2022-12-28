source ~/scripts/init.sh
for f in ~/scripts/bash/*.bash; do source $f; done

# Avoid duplicates
export HISTCONTROL=erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
