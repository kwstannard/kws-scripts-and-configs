source ~/scripts/init.sh

for f in ~/scripts/zsh/*.zsh; do echo $f; source $f; done
