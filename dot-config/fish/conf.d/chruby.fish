if command -s brew
  source $(brew --prefix chruby-fish)/share/fish/vendor_functions.d/chruby_reset.fish
  source $(brew --prefix chruby-fish)/share/fish/vendor_functions.d/chruby_use.fish
  source $(brew --prefix chruby-fish)/share/fish/vendor_functions.d/chruby.fish
  source $(brew --prefix chruby-fish)/share/fish/vendor_conf.d/chruby_auto.fish
end

chruby scripting
