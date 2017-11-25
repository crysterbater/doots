#!/usr/bin/env bash

## written by Nathaniel Maia for ArchLabs Minimo  <natemaia10@gmail.com>
##
## any enquiries https://sourceforge.net/projects/archlabs-linux-minimo/


draw_box(){

#=============#
HORZ="-"
VERT="|"
CORNER_CHAR="+"

MINARGS=4
E_BADARGS=65
#=============#


if [ $# -lt "$MINARGS" ]; then          # If args are less than 4, exit.
    exit $E_BADARGS
fi

# Looking for non digit chars in arguments.
# Probably it could be done better
if echo $@ | tr -d [:blank:] | tr -d [:digit:] | grep . &> /dev/null; then
   exit $E_BADARGS
fi

BOX_HEIGHT=`expr $3 - 1`   #  -1 correction needed because angle char "+"
BOX_WIDTH=`expr $4 - 1`    #+ is a part of both box height and width.
T_ROWS=`tput lines`        #  Define current terminal dimension
T_COLS=`tput cols`         #+ in rows and columns.

if [ $1 -lt 1 ] || [ $1 -gt $T_ROWS ]; then    #  Start checking if arguments
   exit $E_BADARGS                             #+ are correct.
fi
if [ $2 -lt 1 ] || [ $2 -gt $T_COLS ]; then
   exit $E_BADARGS
fi
if [ `expr $1 + $BOX_HEIGHT + 1` -gt $T_ROWS ]; then
   exit $E_BADARGS
fi
if [ `expr $2 + $BOX_WIDTH + 1` -gt $T_COLS ]; then
   exit $E_BADARGS
fi
if [ $3 -lt 1 ] || [ $4 -lt 1 ]; then
   exit $E_BADARGS
fi                                 # End checking arguments.

plot_char(){                       # Function within a function.
   echo -e "\E[${1};${2}H"$3
}

echo -ne "\E[3${5}m"               # Set box frame color, if defined.

# start drawing the box

count=1                                         #  Draw vertical lines using
for (( r=$1; count<=$BOX_HEIGHT; r++)); do      #+ plot_char function.
  plot_char $r $2 $VERT
  let count=count+1
done

count=1
c=`expr $2 + $BOX_WIDTH`
for (( r=$1; count<=$BOX_HEIGHT; r++)); do
  plot_char $r $c $VERT
  let count=count+1
done

count=1                                        #  Draw horizontal lines using
for (( c=$2; count<=$BOX_WIDTH; c++)); do      #+ plot_char function.
  plot_char $1 $c $HORZ
  let count=count+1
done

count=1
r=`expr $1 + $BOX_HEIGHT`
for (( c=$2; count<=$BOX_WIDTH; c++)); do
  plot_char $r $c $HORZ
  let count=count+1
done

plot_char $1 $2 $CORNER_CHAR                   # Draw box angles.
plot_char $1 `expr $2 + $BOX_WIDTH` $CORNER_CHAR
plot_char `expr $1 + $BOX_HEIGHT` $2 $CORNER_CHAR
plot_char `expr $1 + $BOX_HEIGHT` `expr $2 + $BOX_WIDTH` $CORNER_CHAR

tput sgr0 # restore colours
}
# set box size
R=2      # Row
C=6      # Column
H=14     # Height
W=81     # Width
col=1    # Color (red)

# set some paths
BIN="/usr/bin"
MENU="/home/$USER/.config/openbox/menu.xml"
TINT_MENU="/home/$USER/.config/openbox/menu-tint.xml"
RC_PATH="/home/$USER/.config/openbox/rc.xml"
AUTOSTART="/home/$USER/.config/openbox/autostart"
HELPERS="/home/$USER/.config/xfce4/helpers.rc"
MIMEAPP="/home/$USER/.config/mimeapps.list"
CONF_PATH="/home/$USER/.config"

# determine if using nvidia graphics
NV=`lspci | grep -i "nvidia"`

# determine whether virtual environment
VM=`dmesg |grep -i hypervisor`

# string comparison case insesitive matching
yes="y"
no="n"

# colours
b='\E[1;34m'
red='\E[1;31m'
g='\E[1;32m'
y='\E[1;33m'
reg='\E[0m'

# my thanks to the bunsenlabs guys for this nice little hello art
clear; echo -e "\n\n\n                 ${b}              _   _ _____ _     _     ___
                              | | | | ____| |   | |   / _ \\
                              | |_| |  _| | |   | |  | | | |
                              |  _  | |___| |___| |__| |_| |
                              |_| |_|_____|_____|_____\___/\n"; tput sgr0
echo -e "${b}                          Hi${red} ${USER}${b}, Welcome to ArchLabs Linux! ${y}:)\n"; tput sgr0
echo -e "            This will ask some questions in order to setup your installation"
draw_box $R $C $H $W $col; sleep 1; read -n1 -rsp $'\n      Press Any Key to Continue...'
clear
echo -e "\n\n  During the following choices (${red}unless told otherwise${reg}) you may pick as many apps
  as you like, just enter the number of the applications you want installed"
echo -e "\n  Eg. 1${red})${reg}Chrome  2${red})${reg}Chromium  3${red})${reg}Opera
\n  Entering [${red}1 2${reg}], [${red}1,2${reg}], [${red}1-2${reg}], or [${red}12${reg}] all result in
  Chrome & Chromium both being installed with an option to remove Firefox.
\n${red}  Not entering anything will result in the ArchLabs Default Selection of apps${reg}"; sleep 2
read -n1 -rsp $'\n\n  Press Any Key to Continue...'
