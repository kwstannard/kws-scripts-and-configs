if status is-interactive
    # Commands to run in interactive sessions can go here
    set --append PATH $HOME/scripts/bin
    set --append PATH $HOME/bin
end
fish_config theme choose 'Tomorrow Night Bright'
eval "$(/opt/homebrew/bin/brew shellenv)"
set -x --append PATH /opt/local/bin
