#!/bin/bash

### Prerequisites: findimagedupes, zenity, gthumb (or feh+thunar)

### First run will take some time. By default scans ~/Pictures and
### ~/Desktop for possible matches, customise the "folders" variable
### below to change this.

### Run like: ./similar_images image.jpg 
### but it's meant to be run from a file manager like Thunar, so uses
### Zenity to ask for similarity threshold and show progress.

### Example Thunar action (~/.config/Thunar/uca.xml):
# <action>
#         <icon>folder-pictures-symbolic</icon>
#         <name>Find similar images</name>
#         <command>/home/user/bin/similar_images %f</command>
#         <description>Show a list of images that look like this one</description>
#         <patterns>*</patterns>
#         <image-files/>
# </action>

set -e -u

declare -a folders

### Add lines like this to scan non-standard pictures directories:
#folders+=($HOME/other/folder)

### Scan ~/Pictures and ~/Desktop (using their localised names):
if source $HOME/.config/user-dirs.dirs; then
    ### Comment out any that you don't want to use:
    folders+=($XDG_DESKTOP_DIR)
    folders+=($XDG_PICTURES_DIR)
    ### ~/Downloads change a lot and might include lots of big files,
    ### so skip it unless you have a really fast computer:
    #folders+=($XDG_DOWNLOAD_DIR)
fi

### Where we keep our findimagedupes database; this and what follows
### should not need customisation:
db=$HOME/.config/findimagedupes.db
mkdir -p "$(dirname -- "$db")"

filepath=$(readlink -f -- "$1")
filename=$(basename "$filepath")
indir=$(dirname -- "$filepath")


### Poor man's gettext:
declare -A _
export _
_[nn_NO]=1
_[nn_NO|title]="Finn liknande bilete"
_[nn_NO|threshold]="Kor like må bileta vera?"
_[nn_NO|pruning]="Fjernar gamle bilete frå databasen …"
_[nn_NO|updatequestion]="Hopp over oppdatering av biletdatabasen?"
_[nn_NO|scanning]="Skannar"
_[nn_NO|finding]="Finn liknande til "
_[nn_NO|nomatch]="Prøv ein lågare terskel, fann ingen liknande bilete :("
_[nn_NO|toomany]="Prøv ein høgare terskel, fann for mange bilete:"
_[en_GB]=1
_[en_GB|title]="Find similar images"
_[en_GB|threshold]="How similar should the images be?"
_[en_GB|updatequestion]="Skip updating image database?"
_[en_GB|pruning]="Pruning image database …"
_[en_GB|scanning]="Scanning"
_[en_GB|finding]="Finding similar to "
_[en_GB|nomatch]="Try a lower threshold, no similar images found :("
_[en_GB|toomany]="Try a higher threshold, found too many images:"
if [[ -f $HOME/.config/user-dirs.locale && -n ${_[$(cat $HOME/.config/user-dirs.locale)]} ]]; then
    lang=$(cat $HOME/.config/user-dirs.locale)
else
    lang=en_GB
fi

threshold=$(zenity --scale --title "${_[$lang|title]}" --text "${_[$lang|threshold]}" --value 92)

if ! zenity --question --title "${_[$lang|title]}" --text "${_[$lang|updatequestion]}"; then
    # Update image database:
    nice findimagedupes -f "$db" -q --prune       | zenity --progress --pulsate --auto-close --text "${_[$lang|pruning]}" --title "${_[$lang|title]}"
    for dir in "${folders[@]}"; do
        nice findimagedupes -f "$db" -q -R "$dir" | zenity --progress --pulsate --auto-close --text "${_[$lang|scanning]} $dir" --title "${_[$lang|title]}"
    done
    # We don't add the current folder to the database; if the image in
    # /tmp/ or $HOME/ or something, that might take forever …
fi

# The first cutoff with [[ just makes running the script much faster
VIEW() {
    [[ $* = *$filename* ]] &&
    printf "%s\0" "$@" | grep -qzF "$filepath" &&
    printf "%s\0" "$@"
}

trap 'rm -rf "$scriptdir";' EXIT
scriptdir=$(mktemp -d -t imgdupes.XXXXXXXXXX)
# TODO: this bit takes ~20 seconds on my collection – any way to speed things up?
findimagedupes -f "$db" -t "${threshold}%" -s "$scriptdir/s" --include "$(type VIEW|sed 1d)" "$filepath" | zenity --progress --pulsate --auto-close --text "${_[$lang|finding]} $filepath" --title "${_[$lang|title]}"

export filepath                 # so scriptdir/s can read them
export filename
imgs=()
while read -rd $'\0'; do
    imgs+=("$REPLY")
done < <(bash "$scriptdir/s")

open_gthumb () {
    printf "%s\0" "${imgs[@]}" |
    xargs -0 gthumb
}

open_feh_thunar () {
    printf "%s\0" "${imgs[@]}" |
    xargs -0 feh -b trans --thumbnails --cache-thumbnails --thumb-width 256 --thumb-height 256  -g 1024x700 --sort width --draw-actions --action1 'thunar "$(dirname %F)"'
}

if [[ ${#imgs[@]} -eq 0 ]]; then
    zenity --error --title "${_[$lang|title]}" --text "${_[$lang|nomatch]}"
elif [[ ${#imgs[@]} -gt 100 ]]; then
    zenity --error --title "${_[$lang|title]}" --text "${_[$lang|toomany]} ${#imgs[@]}"
else
    open_gthumb
    ### You might prefer open_feh_thunar – I would if it could make
    ### the unloadable XCF's clickable at least. My favourite image
    ### viewer, Mirage, unfortunately has no way of showing thumbs of
    ### _only_ the images specified on the command line, see
    ### https://developer.berlios.de/feature/?func=detailfeature&feature_id=5675&group_id=6637
fi
