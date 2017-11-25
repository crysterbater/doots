#!/bin/bash
#
# preview (neo)vim colors
#
# use "~/.vim/colors" and "vim"
# instead of "~/.config/nvim/colors" and "nvim"
#
# IFF you're a nerd and aren't using neovim yet
#
# usage:
# $ mkdir -p ~/public_html/colors # or whereever...
# $ cd !:2
# $ chmod +x preview-vim-colors.sh
# $ ./preview-vim-colors.sh [PATH TO A SOURCE FILE TO USE]
set -e

echo "<html><head><style>article{float:left;}iframe{border:0;height:33vh;width:19vw;}html,body{margin:0;padding:0;font-family:\"Hack\",monospace;}h1{line-height:1;margin:0;text-align:center;}</style><title>vim colors</title><body>" > index.html
for f in `ls ~/.config/nvim/colors`; do
    c=${f%.vim}
    nvim $1 '+color '$c +TOhtml '+sav! '$c'.html' '+qa!'
    echo "<article><h1>"$c"</h1><iframe src=\""$c".html\"></iframe></article>" >> index.html
done
echo "</body></html>" >> index.html
