#!/bin/bash

# screenshootin' lika boss

scrot ~/Pictures/scrots/scrot_$(date +%F_%T).png
notify-send "screenshot saved at ~/Picture/scrots/scrot_$(date +%F_%T).png"
