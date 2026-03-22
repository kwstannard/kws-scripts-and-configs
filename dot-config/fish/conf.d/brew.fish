if test -d /opt/homebrew/bin
  set -x --prepend PATH /opt/homebrew/bin
end

if test -d "/home/linuxbrew/.linuxbrew"
  set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
  set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
  set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
  fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
  if test -n "$MANPATH[1]"
    set --global --export MANPATH '' $MANPATH
  end
  if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH
    set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH
  end
end
