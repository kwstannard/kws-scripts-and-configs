dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
system_type="$(uname -s)"
echo $system_type

ln -s $dir/configs/vimrc.vim ~/.vimrc
mkdir ~/.config/nvim
ln -s $dir/configs/nvimrc.vim ~/.config/nvim/init.vim

ln -s $dir/configs/vimperatorrc ~/.vimperatorrc
ln -s $dir/configs/$system_type/gitconfig ~/.gitconfig
ln -s $dir/configs/inputrc ~/.inputrc
ln -s $dir/configs/pryrc ~/.pryrc
ln -s $dir/configs/psqlrc ~/.psqlrc

ln -s $dir/configs/$system_type/bashrc ~/.bashrc
ln -s $dir/configs/$system_type/bash_profile ~/.bash_profile

case $system_type in
  "Linux")
    ;;
  "Darwin")
    ;;
esac
