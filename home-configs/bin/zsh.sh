#!/usr/bin/env sh

# install and change shell
brew install zsh
chsh -s /bin/zsh

# install oh-my-zsh themes
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# set powerline fonts
POWERLINE_PATH=/usr/local/lib/python2.7/site-packages/powerline/bindings
# review (source powerline just before source zsh in .zshrc)
sed -i /source/source $POWERLINE_PATH\/zsh\/powerline.zsh/i ~/.zshrc
