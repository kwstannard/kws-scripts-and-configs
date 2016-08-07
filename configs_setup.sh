dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $dir/configs/vimrc.vim ~/.vimrc
mkdir ~/.config/nvim
ln -s $dir/configs/nvimrc.vim ~/.config/nvim/init.vim

ln -s $dir/configs/vimperatorrc ~/.vimperatorrc
ln -s $dir/configs/gitconfig ~/.gitconfig
ln -s $dir/configs/inputrc ~/.inputrc
ln -s $dir/configs/pryrc ~/.pryrc
ln -s $dir/configs/psqlrc ~/.psqlrc

rm ~/.bashrc
ln -s $dir/configs/bashrc ~/.bashrc

case "$(uname -s)" in
  "Linux")
    ;;
  "Darwin")
    ln -s $dir/configs/mac/bash_profile ~/.bash_profile
    ;;
esac
