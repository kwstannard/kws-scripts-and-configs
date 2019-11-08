PATH="/usr/local/sbin:$PATH"

HOMEBREW_PREFIX="/usr/local/homebrew"
PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

for f in ~/scripts/shell_scripts{,/**}/*.sh; do echo $f; source $f; done
PATH="$HOME/scripts/bin:$PATH"

DISABLE_SPRING=1
HISTSIZE=15000
HISTFILESIZE=1000000

source $HOME/.work_env_variables
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
PGDATA=/usr/local/var/postgresql@9.6/
OCI_DIR=/opt/oracle/instantclient_12_2
