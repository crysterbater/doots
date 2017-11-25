#!/usr/bin/env bash

# fetch the colors from colors.sh
source "/usr/scripts/bar/colors.sh"

/usr/scripts/bar/bar.sh | polybar \
    -f '-FontAwesome-*' \
    -f '-MaterialIcons-*' \
    -g "x30" \
    | bash
