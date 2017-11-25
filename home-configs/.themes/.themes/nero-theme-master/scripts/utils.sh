#!/usr/bin/env bash

do_install() {
	local GTKDIR SHELLDIR CINNDIR INSTALL_DIR
	INSTALL_DIR="$1"
	GTKDIR="${INSTALL_DIR}/gtk-3.0"
	SHELLDIR="${INSTALL_DIR}/gnome-shell"

	install -dm755 "${INSTALL_DIR}"

	cd src

	cp index.theme "${INSTALL_DIR}"

	cp -rt "${INSTALL_DIR}" \
			gtk-2.0 gnome-shell xfwm4

	for _DIR in "${GTKDIR}"
	do
		GTKVER="${_DIR##*/}"

		mkdir -p "${_DIR}"

		cp -rt "${_DIR}" \
			"${GTKVER}/gtk.css" \
			"${GTKVER}/assets" \

	done
}

case $1 in
	install)
		do_install "$2"
	;;

	*)
		exit 0
	;;
esac
