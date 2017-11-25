#!/bin/sh
# info.sh
# Output information with formatted background colors in lemonbar format
# This script can take arguments for what bar information to display(meant to be the names of the functions)

# clickable area aliases
AC='%{A:'           # start click area
AB=':}'             # end click area cmd
AE='%{A}'           # end click area
# %{R}              # swap current bg/fg
# %{l}              # aligns to left side
# %{c}              # aligns to center
# %{r}              # aligns to right
##  Colors are formatted in hex (#aarrggbb) or symbolic name (eg. white, indianred,darkgray)
# %{B}              # text BG color, reset with -
# %{F}              # text FG color, reset with -
# %{T}              # sets font used to draw following text, reset with -
# %{U}              # set text underline color, reset with -
# %{A:command:}     # start click area button
##  Eg. %{A:reboot:} Click here to reboot %{A}
##  Eg. %{A:reboot:}%{A3:halt:} Left click to reboot, right click to shutdown %{A}%{A}
# %{S}              # change monitor where bar is rendered
##  Eg. +/- next/prev  f/l first/last  0-9 #monitor
#
##  + attribute sets for following text
##  - attribute unsets for following text
##  ! attribute toggles for following text
##  for     o  draw line over text
##  and     u  draw line under

icon() {
    echo -n -e "%{F$pIcon}\u$1 %{F$pFG}"
}
#weatherPanel() {
#    icon f0c2
#	WSTAT=$(weather --iconify)
#	echo "$WSTAT"
#}

#	weatherURL='http://www.accuweather.com/en/us/austin-tx/78701/weather-forecast/351193'
#   wget -q -O- "$weatherURL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12"°F" }'| head -1
#cliweather | awk '{print $2}' | awk 'NR==4'
#weather
#


cal() {
	#icon f073
#    icon f133
#	echo "${AC}~/.config/bspwm/panel/popup_cal &${AB} $(date +'%a %b%e')${AE}"
	echo ${AC}'dzen_cal &'${AB}$(icon f133)${AE}$(date '+%a %b%e')
}

# new clock
clock() {
    echo $(icon f017)$(date '+%l:%M %p')
}

#panel_clock() {
#    echo "${AC}~/.config/bspwm/panel/popup_cal &${AB} $(date +'%a %b%e') ${AE}%{F-}"
#}


#mail() {
    # todo: this
#    icon f0e0
#    echo '0'
#}

battery() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status
    icon f0e7
    if [ -f $BATC ]; then
        [ "`cat $BATS`" = "Charging" ] && echo -n '+' || echo -n '-'
        cat $BATC
    else
        #no battery information found.
        echo '+100'
    fi
}

volume() {
#    display="$(icon f028) $(amixer get Master | sed -n 's/^.*\[\([0-9]\+%\).*$/\1/p')"
#    command='termite -e "alsamixer"'
#    echo ${AC}$command${AB}$display${AE}
volume=$(amixer -q | grep -A5 Master | grep '%' | cut -d'[' -f2 | cut -d'%' -f1)
playback=$(amixer -q | grep -A5 Master | grep 'Mono: Playback' | cut -d'[' -f4 | cut -d']' -f1)
    if [ "$playback" == "off" ]
    then
        icon=" Mute" #Mute icon f05e
    elif ((0 < volume && volume <= 33))
    then
        icon="" #No Soundbar icon f026
    elif ((33 < volume && volume <= 66))
    then
        icon="" #One Soundbar icon f027
    else
        icon="" #Three Soundbars icon f028
    fi
echo "%{A4:amixer set Master 10%+ > /dev/null${AB}%{A5:amixer set Master 10%- > /dev/null${AB}${AC}~/.config/bspwm/panel/popup_sound &${AB}$icon${AE}${AE}${AE}"

}

network() {
    read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
    if iwconfig $int1 >/dev/null 2>&1; then
        wlan0=$int1
        eth0=$int2
    else
        wlan0=$int2
        eth0=$int1
    fi
    ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 ||int=$wlan0
    icon f1eb || icon f0ac
    ping -W 1 -c 1 8.8.8.8 >/dev/null 2>&1 &&
        echo -e '\uf00c' || echo -e '\uf00d'
}
#mpd() {
#    cur_song=$(basename "$(mpc current)" | sed "s/^\(.*\)\..*$/\1/" | cut -c1-30 )
#
#    icon f025
#    if [ -z "$cur_song" ]; then
#        echo "Stopped"
#    else
#        paused=$(mpc | grep paused)
#        [ -z "$paused" ] && toggle="${AC}mpc pause${AB}$(icon f04c)${AE}" ||
#            toggle="${AC}mpc play${AB}$(icon f04b)${AE}"
#        prev="${AC}mpc prev${AB}$(icon f049)${AE}"
#        next="${AC}mpc next${AB}$(icon f050)${AE}"
#        cur_song="${AC}'dzen_mpd'${AB}$cur_song${AE}"
#        echo "$cur_song  $prev $toggle $next"
#    fi
#}
yaourtUpdates() {
    updates=$(eval yaourt -Qu | wc --lines)
    command='termite -e "yaourt -Syua"'
    echo ${AC}$command${AB}$(icon f062)$updates${AE}
}
themeSwitch() {
    cur_theme=$(cat ~/.bspwm_theme | grep THEME_NAME | cut -c12-)
#    icon f01e
    echo ${AC}'dzen_theme &'${AB}$(icon f01e)$cur_theme${AE}
}
powerButton() {
	echo ${AC}'popup_power &'${AB}$(icon f011)${AE}
}
#determine what to display based on arguments, unless there are none, then display all.
blockActive=false;
while :; do
    buf="S"
    [ -z "$*" ] && items="themeSwitch yaourtUpdates battery network volume cal clock powerButton" \
                || items="$@"
    for item in $items; do
        buf="${buf}$(block $($item))";
    done
    echo "$buf"
    sleep 2 # update interval
done
