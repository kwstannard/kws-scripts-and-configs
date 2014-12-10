function setbashprompt() {
  PS1="$(ruby $HOME/scripts/bash/prompt_runner.rb)\n>> "
}

PROMPT_COMMAND=setbashprompt
