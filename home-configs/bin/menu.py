#!/usr/bin/env python3
# Thunar custom actions launcher for Send to operations
#  Milos Pavlovic 2016 <mpsrbija@gmail.com>
#
#  Save this file to /usr/local/bin/menu.py
#  Setting thunar custom action:
#  Name: Send to
#  Description : Copy file(s) and folder(s) to...
#  Command: tempfile=$(mktemp /tmp/XXXXX); for file in %F; do echo "${file##*/}" >> $tempfile; done; python3 /usr/local/bin/menu.py %d/ $tempfile | python3 /usr/local/bin/docp.py; rm -f $tempfile
#  
#  File Pattern: *
#  Appearance: *
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  


icons=[
["name","icon","command"],
["Send to Home","folder-home",'$HOME/'],
["Send to Desktop","desktop",'$HOME/Desktop/'],
["Send to Documents","folder-documents",'$HOME/Documents/'],
["Send to Downloads","folder-downloads",'$HOME/Downloads/'],
["Send to Music","folder-music",'$HOME/Music/'],
["Send to Pictures","folder-pictures",'$HOME/Pictures/'],
["Send to Videos","folder-videos",'$HOME/Videos/'],
]


import os
import sys
import string
from gi import require_version
require_version('Gtk', '3.0')
from gi.repository import Gtk
from gi.repository.GdkPixbuf import Pixbuf


class Menu:

    def destroy(self, widget, data=None):
        Gtk.main_quit()


    def action(self, button, event, path, data=None):
        if len(sys.argv) > 1 and  path != '':
           files = "{0}".format(sys.argv[1])
           home = os.path.expanduser("~")
           if "$HOME" in path: 
               path = path.replace("$HOME", home)
           src = sys.argv[1]
           file_with_list = sys.argv[2]
           print(src)
           print(path)
           print(file_with_list)
           sys.stdout.flush()
        else:
           print("No file(s) passed. Exiting.")
        Gtk.main_quit()

    def __init__(self):
        self.menu = Gtk.Menu()
        self.menu.connect("hide", self.destroy)
        it=Gtk.IconTheme.get_default()
        j=0
        first=True
        for line in icons:
            if first:
               first=False
               continue  
            try:
               if '/' in line[1]:
                  pixbuf = pixbuf_new_from_file(line[1])
               else:
                  pixbuf = it.load_icon(line[1],24,0)
            except:
               pixbuf = it.load_icon('gtk-stop',24,0)
            name = (line[0])
            path = line[2]

            box = Gtk.Box()
            box.set_spacing(5)
            img = Gtk.Image()
            img.set_from_pixbuf(pixbuf)
            label = Gtk.Label(name)
            box.add(img)
            box.add(label)
            menuitem = Gtk.MenuItem()
            menuitem.add(box)
            menuitem.connect("button-release-event", self.action, path)
            self.menu.append(menuitem)
            j +=1
        height = j*30
        self.menu.set_size_request(0, height)
        self.menu.popup(None, None, None, None, 0, Gtk.get_current_event_time())
        self.menu.show_all()

    def main(self):
        # Cliche init
        Gtk.main()

if __name__ == "__main__":

     app = Menu()
     app.main()
