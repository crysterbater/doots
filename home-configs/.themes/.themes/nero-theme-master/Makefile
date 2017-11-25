SASS=sassc
SASSFLAGS= -I
GTK3_DIR=src/gtk-3.0
SHELL_DIR=src/gnome-shell
GTK3_SASS_DIR=$(GTK3_DIR)/sass
SHELL_SASS_DIR=$(SHELL_DIR)/sass
DIST_DIR=$(RES_DIR)/dist
INSTALL_DIR=$(DESTDIR)/usr/share/themes/Nero
ROOT_DIR=${PWD}
UTILS=scripts/utils.sh

gtk3: clean
all: clean css

css_gtk3:
	$(SASS) $(SASSFLAGS) "$(GTK3_SASS_DIR)" "$(GTK3_SASS_DIR)/gtk.scss" "$(GTK3_DIR)/gtk.css"

css_shell:
	$(SASS) $(SASSFLAGS) "$(SHELL_SASS_DIR)" "$(SHELL_SASS_DIR)/gnome-shell.scss" "$(SHELL_DIR)/gnome-shell.css"

css: css_gtk3 css_shell

clean:
	rm -rf "$(GTK3_DIR)/gtk.css"
	rm -rf "$(SHELL_DIR)/gnome-shell.css"
	rm -rf "$(ROOT_DIR)/dist"

install: all
	$(UTILS) install "$(INSTALL_DIR)"

uninstall:
	rm -rf "$(INSTALL_DIR)"

.PHONY: all
.PHONY: css
.PHONY: clean
.PHONY: install
.PHONY: uninstall

.DEFAULT_GOAL := all

# vim: set ts=4 sw=4 tw=0 noet :
