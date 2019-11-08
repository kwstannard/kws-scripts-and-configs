if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
else
  echo run \`brew install bash-completion\`
fi
