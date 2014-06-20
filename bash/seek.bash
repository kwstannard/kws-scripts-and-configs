#!/bin/bash
seek(){
  ~/scripts/bin/project_grep "$@"
}

seek_all_projects(){
  ruby ~/scripts/seek_all_projects.rb "$@"
}
