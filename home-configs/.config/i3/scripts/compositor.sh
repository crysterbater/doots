#!/usr/bin/env bash

start="al-compositor --start"
restart="al-compositor --restart"
if [ -e "${HOME}/.config/.composite_enabled" ]; then
  if pgrep "compton" > /dev/null; then
    $restart
  else
    $start
  fi
fi
