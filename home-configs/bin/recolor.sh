#!/usr/bin/zsh
# Shell script to recolor a wallpaper using for a specific colorscheme (e.g.
# can be used to recolor wallpapers to go with certain terminal colorschemes).
# Works best for minimalistic wallpapers.
#
# Usage: `./recolor.sh path_to_wallpaper`
# Recolored wallpaper will be saved as `path_to_wallpaper.recolored`.

# The colors to use (in hexadecimal format). Modify to your liking.
declare -a hexes=("1d2021", "ebdbb2", "282828", "928374", "cc241d", "fb4934", \
                  "98971a", "b8bb26", "d79921", "fabd2f", "458588", "83a598", \
                  "b16286", "d3869b", "689d6a", "8ec07c", "a89984")

# Generate palette file.
ppm="P3\n${#hexes[@]} 1\n255\n"
for hex in "${hexes[@]}"; do
    rgb=$(printf "%d %d %d\n" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2})
    ppm="$ppm$rgb\n"
done
palette_file=$(mktemp --suffix=.png)
printf "$ppm" | convert - "$palette_file"

# Recolor wallpaper.
convert "$1" -ordered-dither threshold -remap "$palette_file" "$1.recolored"
