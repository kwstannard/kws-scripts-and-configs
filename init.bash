source ~/scripts/init.sh

for f in ~/scripts/bash/*.bash; do echo $f; source $f; done
