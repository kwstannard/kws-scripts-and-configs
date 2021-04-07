#! /Users/kellystannard/.rubies/scripting/bin/ruby

#begin; require 'term/ansicolor'; rescue LoadError; puts "$ gem install term-ansicolor"; exit; end
require 'mkmf'

# include Term::ANSIColor

def gitbranch
  g = g_working_directory + g_branchname

  # if g_ahead && g_behind
  #   red(g)
  # elsif g_ahead
  #   yellow(g)
  # elsif g_behind
  #   green(g)
  # else
  #   g
  # end
end

def g_branchname
  g_st.match(/branch.head ([\w\/-]*)/).to_a.fetch(1, "not a repo")
end

def g_ahead
  g_st.match(/branch.ab \+[^0]/)
end

def g_behind
  g_st.match(/branch.ab .. -[^0]/)
end

def g_working_directory
  if g_clean
    ""
  else
    "+ "
  end
end

def g_clean
  !g_st.match(/\x00[^#]/)
end

def g_st
  @status ||= %x{ git status --porcelain=v2 -z --branch 2>/dev/null }
end

def gittxt
  gb = gitbranch
  if gb
    ")(#{gb}"
  end
end

puts "\n#{Dir.pwd}  (#{ENV["RUBY_VERSION"]}#{gittxt})  #{Time.now.strftime("%b %e")}"
