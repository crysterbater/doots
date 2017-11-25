#!/bin/bash

RED="\e[1;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[1;34m"
PURPLE="\e[0;35m"
GRAY="\e[0;37m"
NONE="\e[0;0m"

CURRENT_WORK_DIR=${PWD}
echo $CURRENT_WORK_DIR

for SUBDIR in */ ; do
    PROJECT_DIR="$CURRENT_WORK_DIR/$SUBDIR"
    cd $PROJECT_DIR
    echo -e "${BLUE}${SUBDIR}${NONE}"
    if [ ! -d "$CURRENT_WORK_DIR/$SUBDIR/.git" ]; then
       echo -e "${RED}No git here!${NONE}"
    else
       git status -s
       git push --all -n                             
    fi   
done
