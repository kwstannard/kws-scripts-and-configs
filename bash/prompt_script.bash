function setbashprompt() {
  PS1="$(ruby $HOME/scripts/bash/prompt_runner.rb)"
}

PROMPT_COMMAND=setbashprompt
