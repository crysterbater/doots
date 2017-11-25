#!/bin/bash
#########################################################
##            Written by Nathaniel Maia                ##
##       To be run in the directory it is located      ##
##         !Dont run this in some random folder!       ##
#########################################################

## bail out on error
set -e

#########################################################
## Setting variables

failmsg="not found. Not Backing it up, moving on"

# Directories
wd="$PWD"
bin="/usr/bin"


# obmenu-generator
schema="$HOME/.config/obmenu-generator/schema.pl"
newschema="$wd/config/obmenu-generator/schema.pl"

config="$HOME/.config/obmenu-generator/config.pl"
newconfig="$wd/config/obmenu-generator/config.pl"

# menu
newmenu="$wd/config/openbox/menu.xml"
menu="$HOME/.config/openbox/menu.xml"


#scripts
old="$wd/usr-bin/oldmenu"
gen="$wd/usr-bin/genmenu"
#########################################################

echo "################################################################
########           Backing up existing files            ########
################################################################"
sleep 1

## Making backups
if [ -f "$schema" ]
then
	cp $schema $HOME/.config/obmenu-generator/schema-backup.pl
else
	echo "$schema $failmsg"
fi


if [ -f "$config" ]
then
	cp $config $HOME/.config/obmenu-generator/config-backup.pl
else
	echo "$config $failmsg"
fi


if [ -f "$menu" ]
then
	cp $menu $HOME/.config/openbox/menu-backup.xml
else
	echo "$menu $failmsg"
fi

## Running install
if [ -f "$newschema" ]
then
	cp $newschema $HOME/.config/obmenu-generator/schema.pl
else
	echo "$newschema $failmsg"
fi


if [ -f "$newconfig" ]
then
	cp $newconfig $HOME/.config/obmenu-generator/config.pl
else
	echo "$newconfig $failmsg"
fi


if [ -f "$newmenu" ]
then
	cp $newmenu $HOME/.config/openbox/menu.xml
	openbox --reconfigure
else
	echo "$newmenu $failmsg"
fi

# reconfigure openbox
openbox --reconfigure

echo "################################################################
########    Settings Installed && Back ups Created   ###########
################################################################"
echo "################################################################
########     Proceeding with Script Installation        ########
######      This will Require Elevated Privileges         ######
################################################################"
sleep 1


# copying scripts
sudo cp -v $old $bin/oldmenu
sudo cp -v $gen $bin/genmenu


echo "################################################################
############       Succesfully Installed        ################
################################################################"
