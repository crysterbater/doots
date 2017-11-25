#!/usr/bin/env bash

source ~/.rvm/scripts/rvm

rvm install 1.9.3
rvm use --default 1.9.3

cd $HOME

echo 'colorscheme railscasts' >> $HOME/.vimrc.local
echo 'set cursorline' >> $HOME/.vimrc.local

[ -d hashrocket ] || mkdir hashrocket
cd hashrocket

if [ ! -d dotmatrix ]; then
    git clone git://github.com/hashrocket/dotmatrix
fi

cd dotmatrix

cat <<'EOF' > FILES
.ctags
.cvsignore
.gitconfig
.hashrc
.irbrc
.pryrc
.rdebugrc
.rvmrc
.screenrc
.tmux.conf
.vim
.vimrc
.zsh
.zshrc
EOF

bin/install
bin/vimbundles.sh
