#!/bin/bash

#### wget -qO- http://goo.gl/kmNvU | sh

sudo aptitude install -y git

git clone git://gist.github.com/1501928.git gist-1501928
cd gist-1501928
git pull origin master
chmod +x *.sh

echo "Run a installation script"
./openbox-panel-setup.sh
