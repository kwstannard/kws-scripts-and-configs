source ~/scripts/init.sh

for f in ~/scripts/zsh/*.zsh; do echo $f; source $f; done

eval $(ruby ~/Sites/scripts/dev_machine/lib/generate_gem_dir_env_functions.rb)
set_all_gem_dirs
