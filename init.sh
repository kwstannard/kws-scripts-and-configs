export PATH="/usr/local/sbin:$HOME/scripts/bin:$HOME/bin:$PATH"

for f in ~/scripts/shell_scripts/*.sh; do source $f; done

case $- in
    *i*) ;;
      *) return;;
esac
echo init.sh!

export HISTSIZE=500000
export HISTFILESIZE=1000000
