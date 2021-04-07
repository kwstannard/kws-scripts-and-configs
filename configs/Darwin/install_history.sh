set -e

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
dir="$(dirname $0)"
source $dir/install_libs.sh
#github
#repositories

#ln -fs "$HOME/Google Drive/bash_history" "$HOME/.bash_history"
