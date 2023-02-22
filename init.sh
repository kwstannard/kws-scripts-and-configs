echo init.sh!
export PATH="/usr/local/sbin:$HOME/scripts/bin:$HOME/bin:$PATH"

# HOMEBREW_PREFIX="/usr/local"

for f in ~/scripts/shell_scripts/*.sh; do source $f; done

export HISTSIZE=500000
export HISTFILESIZE=1000000
