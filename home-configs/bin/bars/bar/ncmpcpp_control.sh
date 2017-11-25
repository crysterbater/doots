#!/bin/bash

[ $1 ] && vis_bar='━━━' || vis_bar='   '
[ $1 ] && vis_status="yes" || vis_status="no"
[ $1 ] && list_bar='   ' || list_bar='━━━'
[ $1 ] && list_status="no" || list_status="yes"

sed -i "/^progressbar_look/ s/\".*/\"$list_bar\"/" ~/.ncmpcpp/config
sed -i "/^statusbar_visibility/ s/\".*/\"$list_status\"/" ~/.ncmpcpp/config
sed -i "/^progressbar_look/ s/\".*/\"$vis_bar\"/" ~/.ncmpcpp/config_visualizer
sed -i "/^statusbar_visibility/ s/\".*/\"$vis_status\"/" ~/.ncmpcpp/config_visualizer
