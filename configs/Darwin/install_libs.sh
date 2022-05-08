  set -v
  if ! which brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install bash-completion
  #brew cask install slack
  brew install vim
  brew install nvim
  mkdir -p ~/.vim/backup

  brew install bash
	brew install diffutils
	brew install patchutils
  brew install grep
  brew install ripgrep
  brew install git
  brew install gh
  brew cask install keepassxc
  brew cask install dropbox
  brew cask install homebrew/cask-versions/firefox-developer-edition
  brew install tmux
  brew install jq
  brew install yq
  brew install cloc
  brew install postgresql
  brew services start postgresql
  #brew install mysql@5.6
  #brew services start mysql@5.6

  brew tap elastic/tap
  brew install elastic/tap/elasticsearch-full

  brew install https://raw.githubusercontent.com/kwstannard/kws-scripts-and-configs/master/homebrew_tap/skhd.rb
  brew services start skhd

  #cp ~/Google\ Drive/oracle/* ~/Library/Caches/Homebrew/

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
brew install awscli
brew install bat
brew install circleci
brew install coreutils
brew install diffutils
brew install docker
brew install dos2unix
brew install dotenv-linter
brew install ffmpeg
brew install fswatch
brew install fzf
brew install gcc
brew install gifsicle
brew install git-appraise
brew install gnuplot
brew install go-jira
brew install gobject-introspection 
brew install golang
brew install graphviz
brew install helm
brew install hidapi
brew install homeport/tap/dyff
brew install imagemagick
brew install jira-client 
brew install kap
brew install kubectl
brew install derailed/k9s/k9s
brew install libreoffice
brew install libsass
brew install minikube
brew install mumble
brew install mutt
brew install mysql
brew install neomutt
brew install patchutils
brew install postman
brew install python-yq
brew install redis
brew install rustup-init
brew install sqlite
brew install taskell
brew install tldr
brew install tuple
brew install v8
brew install vim
