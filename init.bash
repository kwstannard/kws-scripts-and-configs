source ~/scripts/init.sh
for f in ~/scripts/bash/*.bash; do echo $f; source $f; done

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
