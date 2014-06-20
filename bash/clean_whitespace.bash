clean_whitespace(){
  for f in ~/Sites/apps/*; do
    ~/scripty_scripts/clean_whitespace $f
  done

  clean_whitespace ~/Sites/gems/sakura
  clean_whitespace ~/Sites/gems/duzica
}

