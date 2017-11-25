#! /usr/bin/python3
# rename.py - Renames every .jpg file with its date and time.

import os, re, datetime
from PIL import Image

for filename in os.listdir('.'):
    if filename.lower().endswith('.jpg'):

        unix_time_file = os.path.getmtime(filename)
        readable_time = Image.open(filename)._getexif()[36867].replace(':', '.')
        newfile = readable_time + '.jpg'

        count = 1
        while os.path.exists(newfile) and filename != newfile:
            newfile = readable_time + '(' + str(count) + ').jpg'
            count = count + 1

os.rename(filename, newfile)
