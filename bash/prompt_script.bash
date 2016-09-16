function setbashprompt() {
  PS1="$($HOME/scripts/bash/prompt_runner.rb)\n>> "
# After each command, append to the history file and reread it
  history -a; history -c; history -r
}

PROMPT_COMMAND=setbashprompt
