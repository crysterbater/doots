erc
res=$(echo "scrotshot|clerk|themes|files|bookmarks|google|randr|move|mpd|network|outputs|" | rofi -sep "|" -dmenu -i -p 'rofi shit: ' "" -auto-select)

function sure {
  local res=$(echo "no|yes" | rofi -sep "|" -dmenu -i -p "$1: sure?" -auto-select)
  [[ $res = "yes" ]] && exec $2
}

[[ $res = "scrotshot" ]] && teiler
[[ $res = "clerk" ]]   && clerk
[[ $res = "themes" ]]      && rofi-theme-selector
[[ $res = "file browser" ]]   && rofi -modi "fb:/home/pringle/bin/rofi_modules/rofi-scripts-master/rofi-file-browser.sh" -show fb
[[ $res = "bookmarks" ]]   && buku_run
[[ $res = "google" ]]   && google.py
[[ $res = "randr" ]]    && rofi-randr
[[ $res = "window" ]]    && move_window_to_current
[[ $res = "mpd" ]] && rofi-mpd
[[ $res = "network" ]]  && network.sh
[[ $res = "outputs" ]] && monitor_layout.sh


exit 0
