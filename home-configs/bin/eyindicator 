#! /usr/bin/env bash
#
# Copyright 2016 Israel Sant'Anna <israelsantanna at gmail dot com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
####################################################################
# Options avaiable:                                               ##
#                                                                 ##
# c) Print CAPS                                                   ##
# n) Print NUM                                                    ##
# s) Print SCROLL                                                 ##
# F) Set FOREGROUND_COLORS                                        ##
# B) Set BACKGROUND_COLORS                                        ##
# O) Set OVERLINE_COLORS and print it                             ##
# U) Set UNDERLINE_COLORS and print it                            ##
#                                                                 ##
# The options -[FBOU] require two colors in the format            ##
# <rrggbb>-<rrggbb>, where the first part is for                  ##
# STATUS:ON and the second for STATUS:OFF                         ##
#                                                                 ##
####################################################################

while getopts cnsF:B:O:U:L:R:S: opt; do
  case $opt in
    c) PRINT_CAPS="yes" ;;
    n) PRINT_NUM="yes" ;;
    s) PRINT_SCROLL="yes" ;;
    F) {
          FOREGROUND_COLOR_ON=$(echo $OPTARG | cut -d"-" -f1)
          FOREGROUND_COLOR_OFF=$(echo $OPTARG | cut -d"-" -f2)
       } ;;
    B) {
          BACKGROUND_COLOR_ON=$(echo $OPTARG | cut -d"-" -f1)
          BACKGROUND_COLOR_OFF=$(echo $OPTARG | cut -d"-" -f2)
       } ;;
    O) {
          OVERLINE_COLOR_ON=$(echo $OPTARG | cut -d"-" -f1)
          OVERLINE_COLOR_OFF=$(echo $OPTARG | cut -d"-" -f2)
          PRINT_OVERLINE="yes"
       } ;;
    U) {
          UNDERLINE_COLOR_ON=$(echo $OPTARG | cut -d"-" -f1)
          UNDERLINE_COLOR_OFF=$(echo $OPTARG | cut -d"-" -f2)
          PRINT_UNDERLINE="yes"
       } ;;
  esac
done

BG_BEGIN_ON="%{B#$BACKGROUND_COLOR_ON}"
BG_BEGIN_OFF="%{B#$BACKGROUND_COLOR_OFF}"
BG_END="%{B-}"

FG_BEGIN_ON="%{F#$FOREGROUND_COLOR_ON}"
FG_BEGIN_OFF="%{F#$FOREGROUND_COLOR_OFF}"
FG_END="%{F-}"

if [[ $PRINT_OVERLINE == "yes" && $PRINT_UNDERLINE == "yes" ]]; then
  OVER_UNDER_ON_BEGIN="%{o#$OVERLINE_COLOR_ON +o u#$UNDERLINE_COLOR_ON +u}"
  OVER_UNDER_OFF_BEGIN="%{o#$OVERLINE_COLOR_OFF +o u#$UNDERLINE_COLOR_OFF +u}"
  OVER_UNDER_END="%{-o -u}"
elif [[ $PRINT_OVERLINE == "yes" ]]; then
  OVER_ON_BEGIN="%{o#$OVERLINE_COLOR_ON +o}"
  OVER_OFF_BEGIN="%{o#$OVERLINE_COLOR_OFF +o}"
  OVER_END="%{-o}"
elif [[ $PRINT_UNDERLINE == "yes" ]]; then
  UNDER_ON_BEGIN="%{u#$UNDERLINE_COLOR_ON +u}"
  UNDER_OFF_BEGIN="%{u#$UNDERLINE_COLOR_OFF +u}"
  UNDER_END="%{-u}"
fi

SOURCE=$(xset -q | grep Caps)

CAPS=$(echo $SOURCE | cut -d':' -f 3)
NUM=$(echo $SOURCE | cut -d':' -f 5)
SCROLL=$(echo $SOURCE | cut -d':' -f 7)

applyBgAndFgColors () {
  BG=BG_BEGIN_$2
  FG=FG_BEGIN_$2
  echo "${!BG}${!FG} $1 $FG_END$BG_END"
}

applyOverlineAndUnderline () {
  FORMAT=$1
  if [[ $PRINT_OVERLINE == "yes" && $PRINT_UNDERLINE == "yes" ]]; then
    OVER_UNDER=OVER_UNDER_$2_BEGIN
    FORMAT="${!OVER_UNDER}$FORMAT$OVER_UNDER_END"
  elif [[ $PRINT_OVERLINE == "yes" ]]; then
    OVER=OVER_$2_BEGIN
    FORMAT="${!OVER}$FORMAT$OVER_END"
  elif [[ $PRINT_UNDERLINE == "yes" ]]; then
    UNDER=UNDER_$2_BEGIN
    FORMAT="${!UNDER}$FORMAT$UNDER_END"
  fi
  echo ${FORMAT}
}

if [[ $PRINT_CAPS == "yes" ]]; then
  if [[ $CAPS =~ "on" ]]; then
    FORMAT_CAPS=$(applyBgAndFgColors CAPS ON)
    FORMAT_CAPS=$(applyOverlineAndUnderline "${FORMAT_CAPS}" ON)
  else
    FORMAT_CAPS=$(applyBgAndFgColors CAPS OFF)
    FORMAT_CAPS=$(applyOverlineAndUnderline "${FORMAT_CAPS}" OFF)
  fi
fi

if [[ $PRINT_NUM == "yes" ]]; then
  if [[ $NUM =~ "on" ]]; then
    FORMAT_NUM=$(applyBgAndFgColors NUM ON)
    FORMAT_NUM=$(applyOverlineAndUnderline "${FORMAT_NUM}" ON)
  else
    FORMAT_NUM=$(applyBgAndFgColors NUM OFF)
    FORMAT_NUM=$(applyOverlineAndUnderline "${FORMAT_NUM}" OFF)
  fi
fi

if [[ $PRINT_SCROLL == "yes" ]]; then
  if [[ $SCROLL =~ "on" ]]; then
    FORMAT_SCROLL=$(applyBgAndFgColors SCROLL ON)
    FORMAT_SCROLL=$(applyOverlineAndUnderline "${FORMAT_SCROLL}" ON)
  else
    FORMAT_SCROLL=$(applyBgAndFgColors SCROLL OFF)
    FORMAT_SCROLL=$(applyOverlineAndUnderline "${FORMAT_SCROLL}" OFF)
  fi
fi

echo "$FORMAT_CAPS$FORMAT_NUM$FORMAT_SCROLL"
