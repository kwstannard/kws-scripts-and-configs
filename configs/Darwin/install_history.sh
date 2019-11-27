set -e
install_stuff () {
  set -v
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  utils=<<UTILS
  bash
  bash-completion
  bcal
  brew cask install keepassx
  caskroom/cask/dropbox
  caskroom/cask/slack
  caskroom/versions/firefox-esr
  cloc
  diff-so-fancy
  fd
  git
  grep
  htop
  hub --without-docs
  jq
  koekeishiya/formulae/skhd
  mysql
  nvim
  postgresql
  tmux
  vim
  yq
UTILS
  for util in $utils; do brew install $util; done

  brew services start mysql
  brew services start postgresql
  brew services start skhd

  # RUBY
  brew install chruby
  brew install ruby-install
  gem install term-ansicolor

  mkdir -p ~/.vim/backup

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
}

#install_stuff
github
#repositories

#ln -fs "$HOME/Google Drive/bash_history" "$HOME/.bash_history"
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# setup team_repos
