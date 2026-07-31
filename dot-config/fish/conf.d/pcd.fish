function pcd
  set file ".$(cat $HOME/.i3_project)_dir"
  realpath $argv[1] > $file
  cd $argv[1]
end

set workspace "$(swaymsg -rt get_workspaces | jq -r '.[] | select(.focused) | .name')"
set do_a_cd $(echo $workspace | sed 's/[0-9]//g')
set file ".$(cat $HOME/.i3_project)_dir"
if test -e $file && test -z "$do_a_cd"
  cd $(cat $file)
end
