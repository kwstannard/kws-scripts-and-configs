if [ -f /usr/bin/rbenv ]; then
  eval "$(rbenv init -)"
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
