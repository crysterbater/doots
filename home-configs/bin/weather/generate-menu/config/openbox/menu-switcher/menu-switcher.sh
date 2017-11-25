#!/bin/bash

## Some messages
USAGE="\v\tUsage:\tmenu-switcher [OPTION]
\v\tIf not passed an option the script will create menu entrys
\v\t-h  : Prints this Usage message
\v\t-d  : The script will switch to dynamic menu
\v\t-s  : The script will switch to static menu"
PREVSESSION="\vPrevious run detected
\vEither remove menu-session from
\v$SESSIONPATH
\vto re-run the menu entry setup script
\vor add an entry yourself eg. menu-switcher -d
\v<item label=\"Generate Menu\">
  <action name=\"Execute\">
    <command>genmenu</command>
  </action>
</item>"
#########################################################################################

## variables

MENU="$MENUPATH/menu.xml"
MENUPATH="$HOME/.config/openbox"

SCHEMA="$SCHEMAPATH/schema.pl"
SCHEMAPATH="$HOME/.config/obmenu-generator"

SESSION="$SESSIONPATH/menu-session"
SESSIONPATH="$HOME/.config/openbox/menu-switcher/sessions"

STATICMENU="$SWITCHMENUPATH/menu-static.xml"
SAFEMENU="$SWITCHMENUPATH/menu.xml"
SWITCHMENUPATH="$HOME/.config/openbox/menu-switcher"


###########################################################################################
## not used    ############################################################################

## looking for last line of menu (-2 lines)
LINE=$[`wc -l < $MENU`-2]

## attepmt insert
#    if [ -e "$SAFEMENU" ] && [ -e "$MENU" ]; then
#        awk -v n=$LINE -v s="gibberish here" 'NR == n {print s} {print}' $SAFEMENU > $MENU
#    fi
###########################################################################################
INSERT='<item label="Generate Menu">
        <action name="Execute">
            <command>genmenu</command>
        </action>
    </item>'


# look for help
for arg in "$@"
do
    case "$arg" in
        -h|--help)
            echo -e "$USAGE"
            exit 0
            ;;
        * )
            echo -e "$USAGE"
            exit 0
            ;;
    esac
done


# make required directory
configure(){
    if [ -d "$SWITCHMENUPATH" ] && [ -d "$SESSIONPATH" ]; then
        backup_menu
    else
        mkdir $SWITCHMENUPATH
        mkdir $SESSIONPATH
        backup_menu
    fi
}
# !! but backup first !!
backup_menu(){
    if [ -e "$MENU" ] && [ -e "$SCHEMA" ]; then
        cat $MENU > $SESSIONPATH/menu-backup.xml
        cat $SCHEMA > $SESSIONPATH/schema-backup.pl
        check_sessions
    else
        echo "$MENU not found"
    fi
}


# checking for previous runs and running entry
check_sessions(){
    for $SESSION in $SESSIONPATH; do
        if [ `grep -q 'MENU_ENTRY_RUN=true' "$SESSION"` ] && [ `grep -q 'SCHEMA_ENTRY_RUN=true' "$SESSION"` ]; then
            echo -e $PREVSESSION
        else
            menu_entry
        fi
    done
}



# check for and add entry to static menu

menu_entry(){
    for $MENU in $MENUPATH; do
        if grep -q genmenu "$MENU"; then
            echo "entry already exists"
            break
        elif grep -q "ArchLabs Hello" "$MENU"; then
            sed -i '/label="ArchLabs Hello"/ i\
      <item label="Generate Menu">\
        <action name="Execute">\
          <command>genmenu</command>\
        </action>\
      </item>\
      <separator/>' $MENU
        elif grep -q al-kb-pipemenu "$MENU"; then
            sed -i '/<menu execute="al-kb-pipemenu" id="keybinds" label="Display Keybinds"/ a\
      <item label="Generate Menu">\
        <action name="Execute">\
          <command>genmenu</command>\
        </action>\
      </item>\' $MENU
        elif grep -q al-recent-files-pipemenu "$MENU"; then
            sed -i '/al-recent-files-pipemenu" id="pipe-recentfilesmenu"/ a\
      <item label="Generate Menu">\
        <action name="Execute">\
          <command>genmenu</command>\
        </action>\
      </item>\' $MENU
        elif grep -q "GUI Menu Editor" "$MENU"; then
            sed -i '/<item label="GUI Menu Editor"/ i\
        <item label="Generate Menu">\
          <action name="Execute">\
            <command>genmenu</command>\
          </action>\
        </item>\' $MENU
        elif grep -q al-compositor "$MENU"; then
            sed -i '/<menu execute="al-compositor" id="CompositingPipeMenu" label="Compositor"/ i\
      <separator/>\
      <item label="Generate Menu">\
        <action name="Execute">\
          <command>genmenu</command>\
        </action>\
      </item>\
      <separator/>' $MENU
        elif grep -q oblogout "$MENU"; then
            sed -i '/<item label="Exit"/ i\
    <item label="Generate Menu">\
        <action name="Execute">\
            <command>genmenu</command>\
        </action>\
    </item>\
    <separator/>' $MENU
        else [ -e "$SAFEMENU" ] && [ -e "$MENU" ]; then
            awk -v n=$LINE -v s="    $INSERT" 'NR == n {print s} {print}' $SAFEMENU > $MENU
        fi
        echo MENU_ENTRY_RUN=true > $SESSION
        schema_entry
    done
}

# check for and add entry to SCHEMA
schema_entry(){
    for $SCHEMA in $SCHEMAPATH; do
        if grep -q genmenu "$SCHEMA"; then
            echo "entry already exists"
            break
        elif grep -q 'Obmenu-Generator' "$SCHEMA"; then
            sed -i "/'Obmenu-Generator'/ i\    {item => ['/usr/bin/oldmenu',          'Revert to Basic menu',              'menu-editor']}," $SCHEMA
        elif grep -q 'obmenu-generator -p' "$SCHEMA"; then
            sed -i "/'obmenu-generator -p'/ i\        {item => ['/usr/bin/oldmenu',          'Revert to Basic menu',              'menu-editor']}," $SCHEMA
        else grep -q 'oblogout' "$SCHEMA"; then
            sed -i "/'oblogout'/ i\    {item => ['/usr/bin/oldmenu',          'Revert to Basic menu',              'menu-editor']}," $SCHEMA
            echo SCHEMA_ENTRY_RUN=true >> $SESSION
        fi
    done
}


static_menu(){
    for $MENU in $MENUPATH do
        if grep -q 'MENU_ENTRY_RUN=true' "$SESSION" then
            cp $HOME/.config/openbox/menu-static.xml $HOME/.config/openbox/menu.xml
            openbox --reconfigure
            notify-send 'Success!' 'Reverted to menu before switching.'
        else
            notify-send 'Ooops!' 'It seems a backup was never made or is missing.'
        fi
    done
}

dynamic_menu(){
    for $MENU in $MENUPATH do
        if grep -q 'SCHEMA_ENTRY_RUN=true' "$SESSION" then
            obmenu-generator -s -c
            notify-send 'Success!' 'A new menu was generated.'
        else
            notify-send 'Ooops!' 'A backup was never made & is required.. Nothing was changed.'
        fi
    done
}


## arguments

if [[ $1 = '-d' ]]; then
    if [ -e "$SAFEMENU" ] then
        dynamic_menu
    else
        echo -e $USAGE
    fi
elif [[ $1 = '-s' ]]; then
    if [ -e "$STATICMENU" ] then
        static_menu
    else
        echo -e $USAGE
    fi
elif [[ $1 = '-c' ]]; then
    if [ -e "$MENU" ] && [ -e "$SCHEMA" ]then
        configure
    else
        echo -e "\v\t## Warning ##
        \vEither $MENU
        \vor $SCHEMA
        \vcould not be found
        \vPlease verify they exist and are in the proper locations"
    fi
else [[ $@ = '*' ]]; then
        echo -e $USAGE
fi


exit 0
