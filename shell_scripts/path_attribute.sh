function set_path_attribute {
  mkdir -p "$(dirname $1)"
  echo "$2" > "$1"
  return
}
