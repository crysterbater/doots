#!/bin/bash
 
# Expansions directory constant
EXPANSIONS_DIR=~/.local/share/expansions
# Newline constant
NEWLINE="
"
 
# Save current window focus
CURRENT_WINDOW=`xdotool getwindowfocus`
 
cd $EXPANSIONS_DIR
 
function getchoice()
{
    choice=`ls -1 | rofi -dmenu -p "expand:"`
    if [ -d "$choice" ]; then
        cd $choice
        getchoice
    fi
 
    if [ $choice =~ $NEWLINE ]; then
        if [ "`pwd`" = "$EXPANSIONS_DIR" ]; then
            exit
        else
            cd ..
            getchoice
        fi
    fi
}
getchoice
 
# Restore focus to current window
xdotool windowfocus $CURRENT_WINDOW
 
# Copy current clipboard contents to variables
primary=`xsel -o -p`
clipboard=`xsel -o -b`
 
# Copy expansion to clipboards
echo -n "`cat $choice`" | xsel -i -p
echo -n "`cat $choice`" | xsel -i -b
 
# Paste clipboard
xdotool key --clearmodifiers Shift+Insert
 
# Restore clipboards from variables
echo -n $primary | xsel -i -p
echo -n $clipboard | xsel -i -b
