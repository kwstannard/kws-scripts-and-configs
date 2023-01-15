if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
  . "/usr/local/etc/profile.d/bash_completion.sh"
else
  echo run \`brew install bash-completion@2\`
fi

complete -F _command be
complete -F _command de
