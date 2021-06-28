PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

HOMEBREW_PREFIX="/usr/local"

for f in ~/scripts/shell_scripts/*.sh; do echo $f; source $f; done
PATH="$HOME/scripts/bin:$PATH"

DISABLE_SPRING=1
HISTSIZE=15000
HISTFILESIZE=1000000

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
