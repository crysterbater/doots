#!/usr/bin/env python

import os
import re
import pywal

rofi = ""
dir_path = os.path.dirname(os.path.realpath(__file__))
home_dir = os.path.expanduser("~")

def applyPolybar(background, foreground, background_alt, foreground_alt, vol1, vol2, vol3):
	polybarConf = open("%s/.config/polybar/config" % home_dir).read()
	polybarConf = re.sub(r"background = #.{1,6}", "background = %s" % background.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"foreground = #.{1,6}", "foreground = %s" % foreground.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"background-alt = #.{1,6}","background-alt = %s" % background_alt.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"foreground-alt = #.{1,6}", "foreground-alt = %s" % foreground_alt.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-0 = #.{1,6}", "bar-volume-foreground-0 = %s" % vol1.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-1 = #.{1,6}", "bar-volume-foreground-1= %s" % vol1.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-2 = #.{1,6}", "bar-volume-foreground-2 = %s" % vol1.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-3 = #.{1,6}", "bar-volume-foreground-3 = %s" % vol2.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-4 = #.{1,6}", "bar-volume-foreground-4 = %s" % vol2.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-5 = #.{1,6}", "bar-volume-foreground-5 = %s" % vol2.replace('\n', ''), polybarConf)
	polybarConf = re.sub(r"bar-volume-foreground-6 = #.{1,6}", "bar-volume-foreground-6 = %s" % vol3.replace('\n', ''), polybarConf)

	with open("%s/.config/polybar/config" % home_dir, 'w') as file:
		file.write(polybarConf)

def main():
	colors = []
	with open("%s/.cache/wal/colors" % home_dir) as file:
		colors = file.readlines()
	applyPolybar(colors[0], colors[7], colors[4], colors[8], colors[12], colors[11], colors[10])
main()
