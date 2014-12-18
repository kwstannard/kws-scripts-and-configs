source ~/scripts/init.sh

for f in ~/scripts/zsh/*.zsh; do echo $f; source $f; done

eval $(ruby ~/scripts/shell_scripts/generate_gem_dir_env_functions.rb)
set_all_gem_dirs
