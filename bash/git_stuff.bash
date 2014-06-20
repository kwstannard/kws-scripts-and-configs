_git_fynanz_checkout() {
  __gitcomp "$(__git_refs)"
}

_git_fynanz_push() {
  __gitcomp "$(__git_refs)"
}
