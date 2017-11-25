#!/usr/bin/env bash

rofi_path=$(find "$HOME" -type d -path '*/\.*' -prune -o -not -name '.*' -type d | rofi -dmenu)

[[ $rofi_path != "" ]] && exec urxvt -e zsh -c "cd $rofi_path; zsh -i"
