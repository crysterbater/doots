#!/bin/sh 
cd ~
mv .zsh_history .zsh_history_bad
strings .zsh_history_bad > .zsh_history
# And reload history
fc -R .zsh_history
