if status is-interactive
    # Commands to run in interactive sessions can go here
    set --append PATH $HOME/scripts/bin
    set --append PATH $HOME/bin
end
fish_config theme choose 'Tomorrow Night Bright'
set -x SHELL fish
set -x EDITOR nvim

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/piper/personal/intake/google-cloud-sdk/path.fish.inc' ]; . '/home/piper/personal/intake/google-cloud-sdk/path.fish.inc'; end
