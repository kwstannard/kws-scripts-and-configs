set -v
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
system_type="$(uname -s)"
echo $system_type

ln -fs $dir/configs/vimrc.vim ~/.vimrc
mkdir -p ~/.config/nvim/autoload
mkdir -p ~/.vim/autoload
ln -fs $dir/configs/nvimrc.vim ~/.config/nvim/init.vim
ln -fs $dir/configs/plug.vim ~/.config/nvim/autoload/plug.vim
ln -fs $dir/configs/plug.vim ~/.vim/autoload/plug.vim

ln -fs $dir/configs/vimperatorrc ~/.vimperatorrc
ln -fs $dir/configs/pryrc ~/.pryrc
ln -fs $dir/configs/psqlrc ~/.psqlrc
ln -fs $dir/configs/tmux.conf ~/.tmux.conf

ln -fs $dir/configs/$system_type/bashrc ~/.bashrc
ln -fs $dir/configs/$system_type/bash_profile ~/.bash_profile
ln -fs $dir/configs/$system_type/inputrc ~/.inputrc
ln -fs $dir/configs/$system_type/gitconfig ~/.gitconfig

ln -fs $dir/git_template ~/.git_template

case $system_type in
  "Linux")
    ln -fs $dir/configs/Linux/i3config ~/.config/i3/config
    ln -fs /bin/grep ~/bin/ggrep
    ;;
  "Darwin")
    ruby -r erb -e 'puts ERB.new(File.read(Dir.home+"/scripts/configs/khdrc.erb.conf")).result binding' 0 > ~/.khdrc
    ruby -r erb -e 'puts ERB.new(File.read(Dir.home+"/scripts/configs/skhdrc.erb.conf")).result binding' 0 > ~/.skhdrc
    ;;
esac
