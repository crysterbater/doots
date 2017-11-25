erc
res=$(echo "move windows|randr|displays|directories|" | rofi -sep "|" -dmenu -i -p 'rofi shit: ' "" -auto-select)

function sure {
  local res=$(echo "no|yes" | rofi -sep "|" -dmenu -i -p "$1: sure?" -auto-select)
  [[ $res = "yes" ]] && exec $2
}


[[ $res = "move windowa" ]]      && move_window_to_current
[[ $res = "randr" ]]   && rofi-randr
[[ $res = "displays" ]]  && monitor_layout.sh
[ $res = "displays" ]]  && directories.sh


exit 0
