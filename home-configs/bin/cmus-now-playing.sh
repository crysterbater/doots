#!/bin/bash

# A script to scrape the output of "cmus-remote -Q" to 
# display the current song in Conky. Yes, I know I could
# just use a player app for which Conky includes native 
# support. I like Cmus.


if pidof cmus > /dev/null; then
  artist=`cmus-remote -Q | grep -m 1 'artist' | cut -d' ' -f3-`
  title=`cmus-remote -Q | grep -m 1 'title' | cut -d' ' -f3-`
  album=`cmus-remote -Q | grep -m 1 'album' | cut -d ' ' -f3-`
  date=`cmus-remote -Q | grep -m 1 'date' | cut -d' ' -f3-`
  genre=`cmus-remote -Q | grep -m 1 'genre' | cut -d' ' -f3-`

  if [ -n "$title" ]; then
    echo "$title"
  else
    echo "Album finished/not selected."
  fi
else
  echo "Nothing"
fi
