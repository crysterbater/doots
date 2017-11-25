#!/bin/sh
if [ ! -t 0 ]; then
	x-terminal-emulator -e "$0"
	exit 0
fi
basedir=`dirname "$(readlink -f "${0}")"`
cd ${basedir}
#qss
sh @extra/qt5ct/qss/maketheme.sh
#icons
#create plain svgs
#cd $basedir/@extra/phlat-icons/symbolic
#for f in $(find . -type f -name "*.svg"); do 
#	inkscape --export-plain-svg=$f --vacuum-defs --export-text-to-path --no-convert-text-baseline-spacing --without-gui $f
#done
#cd $basedir/@extra/phlat-icons
#add a padding for bigger icons!
##22px fake
if [ -d $basedir/@extra/phlat-icons/symbolic-22 ]; then
	rm -rfv $basedir/@extra/phlat-icons/symbolic-22
fi
cp -R $basedir/@extra/phlat-icons/symbolic $basedir/@extra/phlat-icons/symbolic-22
cd $basedir/@extra/phlat-icons/symbolic-22
for f in $(find . -type f -name "*.svg");do 
	sed -i 's/viewBox="0 0 16 16"/viewBox="-3 -3 22 22"/' $f
done
cd $basedir
##24px fake
if [ -d $basedir/@extra/phlat-icons/symbolic-24 ]; then
	rm -rfv $basedir/@extra/phlat-icons/symbolic-24
fi
cp -R $basedir/@extra/phlat-icons/symbolic $basedir/@extra/phlat-icons/symbolic-24
cd $basedir/@extra/phlat-icons/symbolic-24
for f in $(find . -type f -name "*.svg");do 
	sed -i 's/viewBox="0 0 16 16"/viewBox="-4 -4 24 24"/' $f
done
cd $basedir
cd $basedir
##32px fake
if [ -d $basedir/@extra/phlat-icons/symbolic-32 ]; then
	rm -rfv $basedir/@extra/phlat-icons/symbolic-32
fi
cp -R $basedir/@extra/phlat-icons/symbolic $basedir/@extra/phlat-icons/symbolic-32
cd $basedir/@extra/phlat-icons/symbolic-32
for f in $(find . -type f -name "*.svg");do 
	sed -i 's/viewBox="0 0 16 16"/viewBox="0 0 16 16" width="32" height="32"/' $f
done
cd $basedir
#emblems
if [ -d $basedir/@extra/phlat-icons/emblems-24 ]; then
	rm -rfv $basedir/@extra/phlat-icons/emblems-24
fi
cp -R $basedir/@extra/phlat-icons/emblems $basedir/@extra/phlat-icons/emblems-24
cd $basedir/@extra/phlat-icons/emblems-24
for f in $(find . -type f -name "*.svg");do 
	sed -i 's/viewBox="0 0 16 16"/viewBox="-4 -4 24 24"/' $f
done
cd $basedir
gtk-update-icon-cache $basedir/@extra/phlat-icons/
#rm -rf .git
#git init
git add .
LANG=C
MESSAGE="$(date)"
git commit -m "$MESSAGE"
#git remote add origin https://github.com/sixsixfive/phlat.git
#git push -u --force origin master
git push origin master
printf "\n...done\n"
exit
