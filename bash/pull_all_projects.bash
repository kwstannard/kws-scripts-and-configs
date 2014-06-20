pull_all_projects(){
  for d in ~/Sites/gems/{elasys_exporter,elasys_btable,experian,ecsi,baycities,certifier,reliamax,paperclip*,month_end_reporting,sakura,duzica}/
  do
    ___pull_project $d
  done
  for d in ~/Sites/apps/*
  do
    ___pull_project $d
  done
}

___pull_project() {
  d=$1
  cd $d
  printf "#####$d######\n"

  branch=`__git_ps1`
  git g
  changes_exist=`git st -s | tr -d ' '`

  if [ "$changes_exist" ]; then
    echo Stashing "$changes_exist"
    git stash clear
    git stash
  fi
  git reset --hard | grep error
  git co . | grep error

  git co dev | grep error
  git pull | grep error
  cd spec/dummy # for sakura/duzica
  bundle install | grep -v Using
  if [ -a ../../db/schema.rb ]
  then
    rake db:migrate db:test:prepare | grep -v 'sec:'
  fi
  git reset --hard | grep error
  git co . | grep error

  echo "$branch" | sed s/[\(\)]//g | xargs git co
  if [ "$changes_exist" ]; then
    git stash pop
  fi
}
