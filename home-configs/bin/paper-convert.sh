#!/bin/bash
##
# Requires Imagemagick

#Colorize, preserves alpha and white elements
#   mogrify -fill 'rgb(x,y,z)' -tint 100 icon.png
# Imgs to convert: folder*.png user-home.png inode-directory.png
#
# cd to ~/.local/share/icons/Paper/ and run script

#tintcolour="rgb(205,168,124)"  # sandy brown   #CDA87C
tintcolour="rgb(24,44,62)"   # blue, from Faenza     #222C42

for f in */places/*;do
    fname=$(basename $f)
    if [[ "$fname" = folder*.png ]] && ! [[ "$fname" = "folder-saved-search.png" ]];then
        mogrify -fill "$tintcolour" -tint 100 "$f"
    fi
done

for f in */places/*;do
    fname=$(basename $f)
    if [[ "$fname" = user-home.png ]];then
        mogrify -fill "$tintcolour" -tint 100 "$f"
    fi
done

for f in */status/*;do
    fname=$(basename $f)
    if [[ "$fname" = folder*.png ]];then
        mogrify -fill "$tintcolour" -tint 100 "$f"
    fi
done

for f in */mimetypes/*;do
    fname=$(basename $f)
    if [[ "$fname" = inode*.png ]];then
        mogrify -fill "$tintcolour" -tint 100 "$f"
    fi
done

## Make terminator use generic terminal icon
#for t in */apps;do
    #if [[ -f "$t/terminator.png" ]];then
        #cp $t/{terminator.png,terminator.png.orig}
        #rm $t/terminator.png
        #ln -rs $t/utilities-terminal.png $t/terminator.png
    #fi
#done
