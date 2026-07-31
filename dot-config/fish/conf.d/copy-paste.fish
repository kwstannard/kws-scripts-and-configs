if test -n WAYLAND_DISPLAY
  alias paste="xsel -ob"
  alias copy="xsel -ib"
else
  alias paste=wl-paste
  alias copy=wl-copy
end
