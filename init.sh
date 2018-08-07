export PATH="/usr/local/sbin:$PATH"
for f in ~/scripts/shell_scripts{,/**}/*.sh; do echo $f; source $f; done
export PATH="$HOME/scripts/bin:$PATH"

export DISABLE_SPRING=1
export HISTSIZE=15000
export HISTFILESIZE=1000000

source $HOME/.work_env_variables
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PGDATA=/usr/local/var/postgresql@9.6/
export OCI_DIR=/opt/oracle/instantclient_12_2
