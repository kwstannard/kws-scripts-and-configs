set -e
install_stuff () {
  set -v
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install bash-completion
  brew install caskroom/cask/slack
  brew install vim
  brew install nvim
  mkdir -p ~/.vim/backup

  brew install bash
  brew install grep
  brew install git
  brew install hub --without-docs
  brew cask install keepassx
  brew install caskroom/cask/dropbox
  brew install caskroom/versions/firefox-esr
  brew install tmux
  brew install jq
  brew install cloc
  brew install postgresql@9.6
  brew services start postgresql@9.6
  brew install mysql@5.6
  brew services start mysql@5.6


  brew install koekeishiya/formulae/skhd
  brew services start skhd

  brew install rbenv
  brew install rbenv-aliases


  gem install term-ansicolor

  cp ~/Google\ Drive/oracle/* ~/Library/Caches/Homebrew/

  brew tap InstantClientTap/instantclient
  brew install instantclient-basiclite
  brew install instantclient-sdk

  brew install htop
  brew install diff-so-fancy
  brew install fd

  git clone https://github.com/jwilm/alacritty ~/alacritty
  pushd ~/alacritty
  make app
  ln -sf $(pwd)/target/release/osx/Alacritty.app/ /Applications/
  popd
}

github() {
  echo key pass?
  read -r pass
  echo file:
  read -r keyfile
  ssh-keygen -t rsa -b 2048 -f "$HOME/.ssh/$keyfile" -C "kstannard@mdsol.com" -N "$pass"
  eval "$(ssh-agent -s)"
  echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/$keyfile" >> $HOME/.ssh/config
  ssh-add -K ~/.ssh/$keyfile
  echo github password?
  read password
  echo github token?
  read token
  curl -X POST \
    -d "{\"title\": \"medidata-$(uuidgen)\", \"key\": \"$(cat "$HOME/.ssh/$keyfile.pub")\"}" \
    -u "kwstannard:$password" \
    -H "Content-Type: application/json" \
    -H "X-GitHub-OTP: $token" https://api.github.com/user/keys
}

repositories() {
  set -v
  #git clone git@github.com:kwstannard/kws-scripts-and-configs ~/scripts
  #bash ~/scripts/configs_setup.sh

  mkdir -p ~/work
  pushd ~/work
  git clone git@github.com:mdsol/plinth
  git clone git@github.com:mdsol/pylon
  git clone git@github.com:mdsol/subjects
  popd
}

#install_stuff
github
#repositories

#ln -fs "$HOME/Google Drive/bash_history" "$HOME/.bash_history"
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
