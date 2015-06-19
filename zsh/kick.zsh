alias kick="ps aux | grep zsh | grep 100.0 | sed 's/.*zsh -c \(.*\)/\1/' | zsh && ps aux | grep zsh | grep 100.0 | sed 's/[a-z]* *\([[:digit:]]*\).*/kill \1/' | zsh"
