alias rbv='ruby -e "print RUBY_VERSION"'
function rbg() {
  g=`rbenv gemset active 2>/dev/null`
    if [ -n "$g" ]; then
      g="@"$g
    else
      g=""
    fi
  echo $g
}
alias rubytxt='echo "[Ruby($(rbv)$(rbg))]"'
#alias railtxt=''
function railtxt() {
re=$RAILS_ENV
if [ "$re" != "" ]; then
  re="[Rails($re)]"
fi
echo $re
}
function gittxt() {
  g=`__git_ps1`
  if [ "$g" == "" ]; then
    g=""
  else
    g="[Git$g]"
  fi
  echo $g
}
export PS1='\n$(date "+%d %B %T") :: \w $(rubytxt) $(railtxt) $(gittxt) \n\[\e[0;36m\]\!\[\e[m\] >> '
