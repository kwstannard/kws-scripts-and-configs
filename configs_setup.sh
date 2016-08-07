dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $dir/configs/vimrc.vim ~/.vimrc
mkdir ~/.config/nvim
ln -s $dir/configs/nvimrc.vim ~/.config/nvim/init.vim

case "$(uname -s)" in
  "Linux")
    echo hi
    ;;
  "Darwin")
    echo oh!
    ;;
esac
