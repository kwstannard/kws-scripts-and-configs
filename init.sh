echo init.sh!
PATH="/usr/local/sbin:$HOME/scripts/bin:$HOME/bin:$PATH"

HOMEBREW_PREFIX="/usr/local"

for f in ~/scripts/shell_scripts/*.sh; do source $f; done

DISABLE_SPRING=1
HISTSIZE=500000
HISTFILESIZE=1000000
