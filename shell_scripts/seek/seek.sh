#!/bin/bash
seek(){
  ~/scripts/bin/project_grep "$@"
}

seek_all_projects(){
  ruby ~/scripts/shell_scripts/seek/seek_all_projects.rb "$@"
}
