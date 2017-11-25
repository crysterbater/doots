#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rofi \
	-show combi \
	-matching normal \
	-combi-modi "window,workspaces:${__dir}/i3_workspaces.py,drun,run,dir:${__dir}/directories.sh,file:${__dir}/files.sh,zsh:${__dir}/zsh_history.sh" \
	-modi combi
