#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  KeyPipe.py
#  
#  2016 Keaton Brown <linux.keaton@gmail.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  

from bs4 import BeautifulSoup as BS
from os.path import expanduser

home=expanduser("~")

print("<openbox_pipe_menu>")
rc = open(home+"/.config/openbox/rc.xml","r").read()
soup = BS(rc,'html.parser')
for name,keybind in sorted([[Keybind.string.lower(),Keybind] for Keybind in soup.find_all("name")]):
	if keybind.parent.parent.parent.name == "keybind":
		print("  <menu id='"+keybind.parent.parent.parent['key']+"' label='"+keybind.parent.parent.parent['key']+"'>")
		print("    <item label='"+name.capitalize()+"'>")
		print("      <action name='Execute'>")
		print("        <execute>"+keybind.parent.parent.command.string+"</execute>")
		print("      </action>")
		print("    </item>")
		print("  </menu>")
print("</openbox_pipe_menu>")
