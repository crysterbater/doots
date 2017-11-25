#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
#-------------------------------------------------------------------------------

feeder.py - version 5
by Vlad George

#-------------------------------------------------------------------------------

Description:
    This script pipes rss and podcast feeds into the openbox menu

Usage:
    First you need the python-feedparser and python-elementtree modules (ubuntu/ archlinux (AUR)),
    place this script in ~/.config/openbox/scripts, make it executable, insert the urls of the feeds
    you want to read in the rss_urls list below, then add following to your ~/.config/openbox/menu.xml:
    "<menu id="feeder-menu" label="rss-feeds" execute="~/.config/openbox/scripts/feeder.py" />...
    <menu id="root-menu" label="Openbox3">...<menu id="feeder-menu" />...</menu>"
    and reconfigure openbox.

Changelog:
    01.07.2007:   1st version
    03.07.2007:   works now (changed "~")....
    05.07.2007:   added cache
    07.10.2007:   added name of rss and sorted output
    03.2008:      added podcast support

#-------------------------------------------------------------------------------

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
http://www.fsf.org/

"""
#-------------------------------------------------------------------------------             
#                             User set variables
#-------------------------------------------------------------------------------             


## your rss feeds:
rss_urls = [
            #('name to be shown', 'url of rss'),
            #('Arch Packages', 'http://www.archlinux.org/feeds/packages/'),
            ('TV2', 'http://tv.animare.hu/rssfeed.aspx?tartalom=aktualistvmusor&tvcsatorna=3'),
        ('RTL Klub', 'http://tv.animare.hu/rssfeed.aspx?tartalom=aktualistvmusor&tvcsatorna=5'),
        ('Viasat3', 'http://tv.animare.hu/rssfeed.aspx?tartalom=aktualistvmusor&tvcsatorna=16'),
        ('M1', 'http://tv.animare.hu/rssfeed.aspx?tartalom=aktualistvmusor&tvcsatorna=1'),
         ]

## browser and audio/video-player to use:
# open_with = "gnome-open"
open_with = "opera"
play_with = "mplayer"

## how many entries should be shown:
rss_feeds_count = 60

## use cache (1 enabled, 0 disabled)
cache = 1

### if cache enabled:

## how old should cache files get - in minutes; set to 0 for manual refresh:
## you can also use >> feeder.py --update << to only update the cache file (useful as cronjob)
age = 30

## temporary directory for cache file (default=/tmp/); leave it as it is.
cache_dir = "/tmp"

#-------------------------------------------------------------------------------
#                                   Script
#-------------------------------------------------------------------------------


def gettingTitles(url_list):
    # get feeds for each url:
    rss_dict = {}
    for i in xrange(len(url_list)):

        rss = feedparser.parse(url_list[i][1])
        rss_entry = []
        try:
            append = rss_entry.append
            if rss.entries[i].has_key('link') == False:
                [append((rss.entries[num].title, None, rss.entries[num].enclosures[0].href)) for num in xrange(rss_feeds_count)]
            elif rss.entries[i].has_key('enclosures') == False:
                [append((rss.entries[num].title, rss.entries[num].link, None)) for num in xrange(rss_feeds_count)]
            else:
                [append((rss.entries[num].title, rss.entries[num].link, rss.entries[num].enclosures[0].href)) for num in xrange(rss_feeds_count)]
        except IndexError:
            pass
        try:
            if url_list[i][0] == '':
                rss_dict[(rss.feed.title, url_list[i][1])] = rss_entry[1:int(rss_feeds_count)]
            else:
                rss_dict[(url_list[i][0], url_list[i][1])] = rss_entry[1:int(rss_feeds_count)]
        except:
            pass
    # rss_dict-items: { ..., ([i][0]:> rss-url, [i][1]:> rss-name):[..., ([i][j][0]:> entry-title, [i][j][1]:> entry-link, [i][j][2]:> entry-podcast_link), ...], ... }
    return rss_dict


def generateXml(dict_url_entry, outfile):
    # sort dict items according display name
    sorted_list = dict_url_entry.items()
    sorted_list.sort()
    # [ ..., (([i][0][0] -> rss-name, [i][0][1] -> rss-url), [..., ([i][1][j][0] -> entry-title, [i][1][j][1] -> entry-link, [i][1][j][2]:> entry-podcast_link), ...]), ... ]
    root = ET.Element("openbox_pipe_menu")
    for i in xrange(len(sorted_list)):
        menu = ET.SubElement(root,"menu", attrib = {"id" : sorted_list[i][0][1], "label" : unicode(sorted_list[i][0][0])})
        for j in xrange(len(sorted_list[i][1])):
            try:
                if sorted_list[i][1][j][2] == None:
                    item = ET.SubElement(menu, "item", attrib = {"label" : unicode(sorted_list[i][1][j][0])})
                    action = ET.SubElement(item, "action", attrib = {"name" : "Execute"})
                    command = ET.SubElement(action, "command")
                    tmp = str(sorted_list[i][1][j][1]).replace('~','%7E')
                    command.text = "%s %s" % (open_with, tmp)
                elif sorted_list[i][1][j][1] == None:
                    podcast_menu = ET.SubElement(menu, "menu", attrib = {"id" : str(int(random.random()*10000000)) + "-menu", "label" : unicode(sorted_list[i][1][j][0])})
                    podcast_play = ET.SubElement(podcast_menu, "item", attrib = {"label" : " play podcast"})
                    podcast_play_action = ET.SubElement(podcast_play, "action", attrib = {"name": "Execute"})
                    podcast_play_execute = ET.SubElement(podcast_play_action, "command")
                    tmp = str(sorted_list[i][1][j][2]).replace('~','%7E')
                    podcast_play_execute.text = "%s %s" % (play_with, tmp)
                else:
                    podcast_menu = ET.SubElement(menu, "menu", attrib = {"id" : str(int(random.random()*10000000)) + "-menu", "label" : unicode(sorted_list[i][1][j][0])})
                    podcast_open = ET.SubElement(podcast_menu, "item", attrib = {"label" : " open "})
                    podcast_open_action = ET.SubElement(podcast_open, "action", attrib = {"name": "Execute"})
                    podcast_open_execute = ET.SubElement(podcast_open_action, "command")
                    tmp1 = str(sorted_list[i][1][j][1]).replace('~','%7E')
                    podcast_open_execute.text = "%s %s" % (open_with, tmp1)
                    podcast_play = ET.SubElement(podcast_menu, "item", attrib = {"label" : " play podcast"})
                    podcast_play_action = ET.SubElement(podcast_play, "action", attrib = {"name": "Execute"})
                    podcast_play_execute = ET.SubElement(podcast_play_action, "command")
                    tmp2 = str(sorted_list[i][1][j][2]).replace('~','%7E')
                    podcast_play_execute.text = "%s %s" % (play_with, tmp2)
            except IndexError:
                pass
    if cache == 1:
        separator = ET.SubElement(root,"separator")
        refresh = ET.SubElement(root,"item", attrib = {"label":"Reload Cache"})
        action2 = ET.SubElement(refresh,"action",attrib = {"name":"Execute"})
        command2 = ET.SubElement(action2,"command")
        command2.text = "%s %s" % (sys.argv[0], "--update")
    tree = ET.ElementTree(root)
    tree.write(outfile)


def ageCheck(age_in_min, file_to_check):
    age_in_sec = int(age_in_min)*60
    file_age = int(time())-int(os.path.getmtime(file_to_check))
    if age_in_min == 0:
        return 1
    elif os.path.isfile(file_to_check) and file_age < age_in_sec:
        return 1
    else:
        return 0


def printXml(xml_entry):
    temp_file = file(xml_entry,'r')
    a = temp_file.read()
    temp_file.close()
    print a


#-------------------------------------------------------------------------------             
#                                    Main
#-------------------------------------------------------------------------------             
import os.path, sys, feedparser
import elementtree.ElementTree as ET
import random
from time import time

#-------------------------#
if __name__ == "__main__" :
#-------------------------#
    if cache == 1:
        cache_file = cache_dir + "/." + str(os.path.split(sys.argv[0])[1]) + "-" + str(os.getuid()) + ".cache"
        if ('--update' in sys.argv[1:]):
            generateXml(gettingTitles(rss_urls), cache_file)
        elif os.path.isfile(cache_file) and ageCheck(age, cache_file):
            print '<?xml version="1.0" encoding="UTF-8"?>'
            printXml(cache_file)
        else:
            generateXml(gettingTitles(rss_urls), cache_file)
            print '<?xml version="1.0" encoding="UTF-8"?>'
            printXml(cache_file)
    else:
        print '<?xml version="1.0" encoding="UTF-8"?>'
        generateXml(gettingTitles(rss_urls), sys.stdout)
