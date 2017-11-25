#!/usr/bin/env python
#
# Author: John McKnight <jmcknight@gmail.com>
# License: GPL 2.0
#
# This script depends on py-libmpdclient which you can get from 
# http://www.musicpd.org/py-libmpdclient.shtml
#
# Usage:
# Put an entry in ~/.config/openbox/menu.xml:
# <menu id="mpd" label="MPD" execute="~/.config/openbox/scripts/ob-mpd-$version.py" />
#
# Then put the following wherever you'd like it to be displayed in your menu:
# <menu id="mpd" />
#
# New in 0.2:  Added a controls menu that allows you to play, pause and stop
#              MPD from the Openbox menu.
