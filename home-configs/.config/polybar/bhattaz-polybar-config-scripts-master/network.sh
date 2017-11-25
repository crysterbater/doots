#!/usr/bin/env bash

online=$(ip addr | grep "state UP" | cut -d ":" -f2)

connected=""
offline=""

if [[ "$online" ]]; then
    echo %{F#EFF0F1}${connected}
  else
    echo %{F#EFF0F1}${offline}; sleep 0.5; echo %{F#E64141}${offline}
    sleep 0.5;echo %{F#EFF0F1}${offline}; sleep 0.5; echo %{F#E64141}${offline}
fi
