#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODI_WORKSPACE="workspaces:${__dir}/modes/i3_workspaces.py"
MODI_SETTING="setting:${__dir}/settings.sh"
MODI_DIR="dir:${__dir}/modes/directories.sh"
MODI_FILE="file:${__dir}/modes/files.sh"
MODI_ZSH="zsh:${__dir}/modes/zsh_history.sh"

rofi \
	-show combi \
	-matching normal \
	-combi-modi "window,${MODI_WORKSPACE},drun,${MODI_SETTING},run,${MODI_DIR},${MODI_FILE},${MODI_ZSH}" \
	-modi combi
