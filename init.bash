source ~/scripts/init.sh
for f in ~/scripts/bash/*.bash; do source $f; done

# exit for non-interactive mode
case $- in
    *i*) ;;
      *) return;;
esac

# Avoid duplicates
export HISTCONTROL=erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
