#!/bin/sh

if [[ $# != 3 ]]; then
   echo "use: crossfehde <resolution> <seconds> <directory>"
   echo "example: crossfehde '1280x1024' '60' '/path/to/images'"
   exit 2
fi

res="$1"
delay="$2"
indir="$3"
xftempdir="${xftempdir:-/tmp/xfehde}"
mkdir -p "$xftempdir"

prepare()  # source file, destination basename : full destination name
{
  filename="$(basename "$1")"
  extension="${filename##*.}"
  #filename="${filename%.*}"
  dest="$xftempdir/$2.$extension"
  dest_r="$xftempdir/${2}1.jpg"
  rm -f "$dest_r"
  if [[ ! -f "$1" ]]; then
    return 1
  fi
  cp "$1" "$dest"
  nice convert "$dest" -gamma 0.454545 -resize ${res}^ -gravity center -extent $res -gamma 2.2 "$dest_r" || return 1
  echo "$dest_r"
}


a=""
b=""
while [[ 1 ]]; do
  images=$(find "$indir" -type f -iregex '.*\(jp\|jpe\|pn\)g' | shuf)
  while read line; do
    a="$b"
    b="$line"
    if [[ ! "$a" ]]; then continue; fi
    a1=$(prepare "$a" "a")
    if [[ ! "$a1" ]]; then continue; fi
    b1=$(prepare "$b" "b")
    if [[ ! "$b1" ]]; then b="$a"; continue; fi

    for i in $(seq 0 5 100); do
      #composite -blend $i \( b1.jpg -blur 0x$(( i/10 )) \) \( a1.jpg -blur 0x$(( 10 - i/10 )) \) c${i}.jpg
      nice composite -blend $i "$b1" "$a1" "$xftempdir/c${i}.jpg"
    done

    for i in $(seq 0 5 100); do
      feh --bg-fill "$xftempdir/c${i}.jpg" &> /dev/null
      #habak -mC -hi "$xftempdir/c${i}.jpg"
      #sleep 0.1
    done
    sleep $delay
  done <<< "$images" 
done



