set -v
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
system_type="$(uname -s)"
echo $system_type

ln -fs $dir/configs/vimrc.vim ~/.vimrc
mkdir -p ~/.vim/autoload

for f in $(ls $dir/dot-config); do ln -fs $dir/dot-config/$f ~/.config/$f; done

ln -fs $dir/configs/vimperatorrc ~/.vimperatorrc
ln -fs $dir/configs/pryrc ~/.pryrc
ln -fs $dir/configs/psqlrc ~/.psqlrc
ln -fs $dir/configs/tmux.conf ~/.tmux.conf

ln -fs $dir/configs/$system_type/bashrc ~/.bashrc
ln -fs $dir/configs/$system_type/bash_profile ~/.bash_profile
ln -fs $dir/configs/$system_type/inputrc ~/.inputrc
ln -fs $dir/configs/$system_type/gitconfig ~/.gitconfig
ln -fs $dir/configs/$system_type/gitattributes ~/.gitattributes

ln -fs $dir/git_template ~/.git_template

case $system_type in
  "Linux")
    ln -fs /bin/grep ~/bin/ggrep
    ln -fs $dir/configs/Linux/xmodmaprc ~/.xmodmaprc
    ln -fs $dir/configs/Linux/xinit ~/.xinit
    ;;
  "Darwin")
    ruby -r erb -e 'puts ERB.new(File.read(Dir.home+"/scripts/configs/khdrc.erb.conf")).result binding' 0 > ~/.khdrc
    ruby -r erb -e 'puts ERB.new(File.read(Dir.home+"/scripts/configs/skhdrc.erb.conf")).result binding' 0 > ~/.skhdrc
    ;;
esac
