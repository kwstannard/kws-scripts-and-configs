#!/bin/sh

shopt -s expand_aliases  
for f in ~/scripts/vim_bash/*; do echo $f; source $f; done
