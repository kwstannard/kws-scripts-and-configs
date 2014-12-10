swc() {
  if [ -n "$1" ]; then
    g=$1
  else
    g="."
  fi
  find $g -name "*.rb" | xargs wc -l | sort -r
}
