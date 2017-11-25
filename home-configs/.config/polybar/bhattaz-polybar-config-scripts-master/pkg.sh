#!/usr/bin/env bash

pac=$(checkupdates | wc -l)

if [[ "$pac" > "0" ]]
then
    echo %{F#EFF0F1}$pac %{F#EFF0F1}
fi


# remove above and uncomment below for aur update checks as well

#pac=$(checkupdates | wc -l)
#aur=$(cower -u | wc -l)

#check=$((pac + aur))
#if [[ "$check" > "0" ]]
#then
#    echo %{F#EFF0F1}$pac %{F#EFF0F1}%{F#EFF0F1} $aur
#fi
