set -e
install_stuff () {
  set -v
  if ! which brew; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew install bash-completion
  #brew cask install slack
  brew install vim
  brew install nvim
  mkdir -p ~/.vim/backup

  brew install bash
  brew install grep
  brew install ripgrep
  brew install git
  brew install gh
  brew cask install keepassx
  brew cask install dropbox
  brew cask install homebrew/cask-versions/firefox-developer-edition
  brew install tmux
  brew install jq
  brew install yq
  brew install cloc
  brew install postgresql@9.6
  brew services start postgresql@9.6
  brew install mysql@5.6
  brew services start mysql@5.6


  brew install koekeishiya/formulae/skhd
  brew services start skhd

  #cp ~/Google\ Drive/oracle/* ~/Library/Caches/Homebrew/

  # brew tap InstantClientTap/instantclient
  # brew install instantclient-basiclite
  # brew install instantclient-sdk

  brew install htop
  brew install diff-so-fancy
  brew install fd
  brew install chruby
  brew install ruby-install

#  git clone https://github.com/jwilm/alacritty ~/alacritty
#  pushd ~/alacritty
#  make app
#  ln -sf $(pwd)/target/release/osx/Alacritty.app/ /Applications/
#  popd
}

github() {
  echo ssh key pass?
  read -r pass
  echo ssh key file:
  read -r keyfile
  ssh-keygen -t rsa -b 2048 -f "$HOME/.ssh/$keyfile" -C "kwstannard@gmail.com" -N "$pass"
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
    -d "{\"title\": \"$(user)-$(uuidgen)\", \"key\": \"$(cat "$HOME/.ssh/$keyfile.pub")\"}" \
    -u "kwstannard:$password" \
    -H "Content-Type: application/json" \
    -H "X-GitHub-OTP: $token" https://api.github.com/user/keys
}

fix_defaults() {
  defaults write -g KeyRepeat -int 1
  defaults write -g InitialKeyRepeat -int 10
  defaults write com.apple.AppleMultiTouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
  defaults write com.apple.AppleMultiTouchTrackpad TrackpadPinch -int 0
  defaults write com.apple.AppleMultiTouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 0
  defaults write -g com.apple.swipescrolldirection -int 0
}

#fix_defaults
install_stuff
#github
#repositories

#ln -fs "$HOME/Google Drive/bash_history" "$HOME/.bash_history"
