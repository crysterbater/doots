#!/bin/sh
# Borrowed from http://marcparadise.com/blog/2013/09/21/how-to-fix-a-corrupt-history-file/
# If you ever see a message like this upon starting a new shell
# zsh: corrupt history file /home/marc/.zsh_history
# here is a quick fix
cd ~
mv .zsh_history .zsh_history_bad
strings .zsh_history_bad > .zsh_history
# And reload history
fc -R .zsh_history
