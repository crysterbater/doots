#!/bin/bash
set -e
_dir=`dirname "$(readlink -f "${0}")"`
_basedir=${_dir}
cd ${_basedir}
if [ -f ${_basedir}/phlat*.rpm ]; then
    rm -f ${_basedir}/phlat*.rpm
fi
if [ -f ${_basedir}/phlat.spec ]; then
    rm -f ${_basedir}/phlat.spec
fi
if [ -d ${_basedir}/phlat ]; then
    rm -rf ${_basedir}/phlat
fi
mkdir -p ${_basedir}/phlat/usr/share/themes/phlat
#creating the spec file:
cat <<\EOFALL> ${_basedir}/phlat.spec
Buildroot: BUILDROOT
Name: phlat
Version: 1.0
Release: 1
Summary: Plain and simple dark theme without any specials...
License: CC-BY-SA_V4
Requires: unzip, curl, findutils ,libgtk-3-0 >= 3.20, gtk2-engine-mist, gtk2-engine-murrine, hicolor-icon-theme
Provides: phlat = %version, gnome-icon-theme
Obsoletes: phlat <= %version
Recommends: gtk3-nocsd, qt5ct, qt5-style-plugins, xfwm4, marco, metacity, icewm, openbox, xfce4-notifyd, xfdashboard, onboard, audacious
Group: System/GUI/Xfce
BuildArch: noarch

%define _rpmdir ../
%define _unpackaged_files_terminate_build 0
%define _source_payload w9.xzdio
%define _binary_payload w9.xzdio
%description
Plain and simple dark theme

%post
if [ -f /usr/share/themes/phlat/files ];then
	for _file in $(cat /usr/share/themes/phlat/files) ; do
		if [ -L $_file ]; then
			rm -fv "$_file"
		fi
		if [ -f $_file ]; then
			rm -fv "$_file"
		fi
	done
#dirs!
	rm -f /usr/share/themes/phlat/files
#re-enable the overlay scrollbars
	sed -i '/^#phlat$/,+1 d' /etc/environment
fi
_tmpdir="/tmp/phlat.tmp"
if [ -d ${_tmpdir} ]; then
	rm -r ${_tmpdir}
fi
#dirs!
mkdir -p ${_tmpdir}/usr/share/themes
#downloading and extracting
cd /tmp
curl -L https://codeload.github.com/sixsixfive/Phlat/zip/master > /tmp/phlat.zip
if [ -f /tmp/phlat.zip ]; then
	unzip /tmp/phlat.zip -d ${_tmpdir}/usr/share/themes
	mv ${_tmpdir}/usr/share/themes/phlat-master ${_tmpdir}/usr/share/themes/phlat
fi
###link all themes
if [ -d ${_tmpdir}/usr/share/themes/phlat ]; then
#icewm theme
	mkdir -p ${_tmpdir}/usr/share/icewm/themes
	ln -sf ../../themes/phlat/@extra/icewm/phlat ${_tmpdir}/usr/share/icewm/themes/phlat
#plank theme
	mkdir -p ${_tmpdir}/usr/share/plank/themes
	ln -sf ../../themes/phlat/@extra/plank/phlat ${_tmpdir}/usr/share/plank/themes/phlat
	ln -sf ../../themes/phlat/@extra/plank/phlat-full ${_tmpdir}/usr/share/plank/themes/phlat-full
#onboard
	mkdir -p ${_tmpdir}/usr/share/onboard/themes
	ln -sf ../../themes/phlat/@extra/onboard/phlat.colors ${_tmpdir}/usr/share/onboard/themes
	ln -sf ../../themes/phlat/@extra/onboard/phlat.theme ${_tmpdir}/usr/share/onboard/themes
#qt5ct
	mkdir -p ${_tmpdir}/usr/share/qt5ct/colors ${_tmpdir}/usr/share/qt5ct/qss
	ln -sf ../../themes/phlat/@extra/qt5ct/colors/phlat_QGtkStyle.conf ${_tmpdir}/usr/share/qt5ct/colors
	ln -sf ../../themes/phlat/@extra/qt5ct/qss/phlat_QGtkStyle.qss ${_tmpdir}/usr/share/qt5ct/qss
#hidpi
	ln -sf phlat/@extra/phlat-hidpi ${_tmpdir}/usr/share/themes/phlat-HiDPI
#icon theme
	mkdir -p ${_tmpdir}/usr/share/icons
	ln -sf ../themes/phlat/@extra/phlat-icons ${_tmpdir}/usr/share/icons/phlat
#WinAMP theme(audacious example)
	mkdir -p ${_tmpdir}/usr/share/audacious/Skins
	ln -sf ../../themes/phlat/@extra/WinAMP/phlat ${_tmpdir}/usr/share/audacious/Skins/phlat
#wallpapers
	mkdir -p ${_tmpdir}/usr/share/backgrounds/phlat_patterns
	mkdir -p ${_tmpdir}/usr/share/backgrounds/xfce
	mkdir -p ${_tmpdir}/usr/share/mate-background-properties
	mkdir -p ${_tmpdir}/usr/share/gnome-background-properties
	for _f in $(find ${_tmpdir}/usr/share/themes/phlat/@extra/backgrounds/patterns -type f|sed 's\^.*/\\g'); do
		ln -s ../../themes/phlat/@extra/backgrounds/patterns/$_f ${_tmpdir}/usr/share/backgrounds/phlat_patterns/$_f
	done
	for _f in $(find ${_tmpdir}/usr/share/themes/phlat/@extra/backgrounds/patterns -type f|sed 's\^.*/\\g'); do
		ln -s ../../themes/phlat/@extra/backgrounds/patterns/$_f ${_tmpdir}/usr/share/backgrounds/xfce/$_f
	done
	cat <<\EOF > ${_tmpdir}/usr/share/mate-background-properties/phlat_patterns.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "mate-wp-list.dtd">
<wallpapers>

EOF
	for _f in $(find ${_tmpdir}/usr/share/themes/phlat/@extra/backgrounds/patterns -type f|sed 's\^.*/\\g'); do
		cat << EOF2 >> ${_tmpdir}/usr/share/mate-background-properties/phlat_patterns.xml
	<wallpaper deleted="false">
		<name>$_f</name>
		<filename>/usr/share/backgrounds/phlat_patterns/$_f</filename>
		<shade_type>vertical-gradient</shade_type>
		<pcolor>#343434</pcolor>
		<scolor>#444444</scolor>
		<options>wallpaper</options>
		<artist>sixsixfive</artist>
	</wallpaper>
EOF2
done
	cat <<\EOF3 >> ${_tmpdir}/usr/share/mate-background-properties/phlat_patterns.xml
	
</wallpapers>
EOF3

ln -s ../mate-background-properties/phlat_patterns.xml ${_tmpdir}/usr/share/gnome-background-properties/phlat_patterns.xml

#configstuff
#	mkdir -p ${_tmpdir}/usr/share/applications
#	ln -sf ../themes/phlat/@extra/scripts/phlat.desktop ${_tmpdir}/usr/share/applications
#no overlay scrollbars
#	mkdir -p ${_tmpdir}/etc/X11/Xsession.d
#	printf "export GTK_OVERLAY_SCROLLING=0\nexport LIBOVERLAY_SCROLLBAR=0\n" > ${_tmpdir}/etc/X11/Xsession.d/98_phlat
#xsession.d was a good idea however it wont work with root apps like synaptic so use /etc/environment instead
	printf '\n#phlat\nGTK_OVERLAY_SCROLLING=0\n#phlat\nLIBOVERLAY_SCROLLBAR=0\n'>> /etc/environment
#create a file list!
	find ${_tmpdir} > ${_tmpdir}/usr/share/themes/phlat/files
	sed -i 's|^/tmp/phlat.tmp||g' ${_tmpdir}/usr/share/themes/phlat/files
#install to 
	chmod -R 755 ${_tmpdir}
	cp -R ${_tmpdir}/* /
	sh /usr/share/themes/phlat/@extra/scripts/changecolor.sh -c "#35B9AB"
fi

%preun

for _file in $(cat /usr/share/themes/phlat/files) ; do
  if [ -L $_file ]; then
    rm -fv "$_file"
  fi
  if [ -f $_file ]; then
    rm -fv "$_file"
  fi
done
#dirs!
rm -f /usr/share/themes/phlat/files
#re-enable the overlay scrollbars
sed -i '/^#phlat$/,+1 d' /etc/environment
#rm -rf /usr/share/themes/phlat

%files
%defattr(-,root,root,-)
%dir /usr/share/themes/phlat
EOFALL

rpmbuild -bb --buildroot=${_basedir}/phlat ${_basedir}/phlat.spec
if [ -f ${_basedir}/../noarch/phlat*.rpm ]; then
    mv ${_basedir}/../noarch/phlat*.rpm ${_basedir}
    rm -rf ${_basedir}/../noarch ${_basedir}/phlat.spec
fi
