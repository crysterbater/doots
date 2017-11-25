# -*- coding: utf-8 -*-
# Rips a SC user's track list, embeds metadata into audio files

# To find the RSS feed URL, go to Settings > Content
# Make sure all your tracks are included in the RSS feed
# under permissions > Include in RSS feed
# Note that downloads from the RSS feed will affect your play count stats

# Requirements: lxml, mutagen

import os
import sys
import time
import os.path
import logging
import subprocess

import mutagen
from lxml import etree
from mutagen.easyid3 import EasyID3

EasyID3.RegisterTextKey('comment', 'COMM')
RSSURL = 'http://feeds.soundcloud.com/users/soundcloud:users:%s/sounds.rss'


def main(userid, destdir):
    if not os.path.isdir(destdir):
        os.mkdir(destdir)

    if userid.startswith('http://'):
        url = userid
    else:
        url = RSSURL % userid

    resp = subprocess.check_output(['curl', '-s', url])

    try:
        feed = etree.fromstring(resp)
    except etree.XMLSyntaxError:
        logging.info('Got invalid response: %s' % resp)
        return

    i = 0
    author = feed.find('channel/title').text
    tracks = list(feed.iterfind('.//item'))
    trackcount = len(tracks)
    logging.info('Found %s tracks in RSS feed' % trackcount)

    for t in tracks:
        i += 1
        audio = t.find('enclosure')
        if audio is None:
            continue

        audiourl = audio.get('url')
        fn = os.path.basename(audiourl)
        fp = os.path.join(destdir, fn)
        logging.info('Downloading track %s/%s - %s' % (i, trackcount, fn))
        subprocess.call(['curl', '-Lso', fp, audiourl])

        d, m, y = t.find('pubDate').text[5:16].split(' ')

        try:
            f = mutagen.File(fp, easy=True)
            f.add_tags()
        except Exception as e:
            logging.warning(e)

        try:
            f['artist'] = author
            f['title'] = t.find('title').text
            f['date'] = time.strftime('%d%m', time.strptime(d + m, '%d%b'))
            f['comment'] = t.find('description').text + ' ' + y
            f.save()
        except Exception as e:
            logging.warning('Failed to tag track %s: %s' % (fn, e))


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    if len(sys.argv) < 3:
        s = os.path.basename(sys.argv[0])
        print('Usage: %s userid/URL destination' % s)
        sys.exit(1)

    main(sys.argv[1], os.path.abspath(sys.argv[2]))
sys.exit(0)
