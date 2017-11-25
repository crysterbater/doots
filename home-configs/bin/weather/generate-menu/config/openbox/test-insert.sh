#!/bin/bash


MENUPATH="$HOME/.config/openbox"
SWITCHMENUPATH="$HOME/.config/openbox/menu-switcher"
SCHEMAPATH="$HOME/.config/obmenu-generator"
SESSIONPATH="$HOME/.config/openbox/menu-switcher/sessions"

MENU="$MENUPATH/menu.xml"
SCHEMA="$SCHEMAPATH/schema.pl"
SAFESCHEMA="$SESSIONPATH/schema-backup.pl"
SESSION="$SESSIONPATH/menu-session"
STATICMENU="$SWITCHMENUPATH/menu-static.xml"
SAFEMENU="$SESSIONPATH/menu-backup.xml"
TMP_MENU="$MENUPATH/tmp_menu"

LINE=$[`wc -l < $MENU`-2]
INSERT='<item label="Generate Menu">
        <action name="Execute">
            <command>genmenu</command>
        </action>
    </item>'


menu_entry(){
    for x in $MENUPATH; do
        if grep -q genmenu "$MENU";
        then
            echo "entry already exists"
        fi
        elif grep -q "ArchLabs Hello" "$MENU";
        then
            sed -i '/label="ArchLabs Hello"/ i\
          <item label="Generate Menu">\
            <action name="Execute">\
              <command>genmenu</command>\
            </action>\
          </item>\
          <separator/>' $MENU
        fi
        elif grep -q al-kb-pipemenu "$MENU";
        then
            sed -i '/<menu execute="al-kb-pipemenu" id="keybinds" label="Display Keybinds"/ a\
          <item label="Generate Menu">\
            <action name="Execute">\
              <command>genmenu</command>\
            </action>\
          </item>\' $MENU
        fi
        elif grep -q al-recent-files-pipemenu "$MENU";
        then
            sed -i '/al-recent-files-pipemenu" id="pipe-recentfilesmenu"/ a\
          <item label="Generate Menu">\
            <action name="Execute">\
              <command>genmenu</command>\
            </action>\
          </item>\' $MENU
        fi
        elif grep -q "GUI Menu Editor" "$MENU";
        then
            sed -i '/<item label="GUI Menu Editor"/ i\
            <item label="Generate Menu">\
              <action name="Execute">\
                <command>genmenu</command>\
              </action>\
            </item>\' $MENU
        fi
        elif grep -q al-compositor "$MENU";
        then
            sed -i '/<menu execute="al-compositor" id="CompositingPipeMenu" label="Compositor"/ i\
          <separator/>\
          <item label="Generate Menu">\
            <action name="Execute">\
              <command>genmenu</command>\
            </action>\
          </item>\
          <separator/>' $MENU
        fi
        elif grep -q oblogout "$MENU";
        then
            sed -i '/<item label="Exit"/ i\
        <item label="Generate Menu">\
            <action name="Execute">\
                <command>genmenu</command>\
            </action>\
        </item>\
        <separator/>' $MENU
        fi
        else [ -e "$SAFEMENU" ] && [ -e "$MENU" ];
            then
                awk -v n=$LINE -v s="    $INSERT" 'NR == n {print s} {print}' $SAFEMENU > $MENU
        fi
    done
}
menu_entry
