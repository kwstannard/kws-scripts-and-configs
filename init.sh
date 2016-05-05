for f in ~/scripts/shell_scripts{,/**}/*.sh; do echo $f; source $f; done

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/scripts/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/scripts/pull_all_projects:$PATH"

export DISABLE_SPRING=1
