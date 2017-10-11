export PATH="/usr/local/sbin:$PATH"
for f in ~/scripts/shell_scripts{,/**}/*.sh; do echo $f; source $f; done
export PATH="$HOME/scripts/bin:$PATH"

export DISABLE_SPRING=1
export HISTSIZE=15000
export HISTFILESIZE=1000000
