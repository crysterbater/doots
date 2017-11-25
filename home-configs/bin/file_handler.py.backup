#!/usr/bin/python
from dmenu import dmenu
import sys
import subprocess
 
choices = [
        'thunar',
        'firefox',
        ]
 
 
if len(sys.argv) <2:
    print("Call this with file url as argument.")
    sys.exit()
 
cmd = dmenu.show(choices, prompt='Choose application')
 
 
print(subprocess.call([cmd, sys.argv[1]]))
