#!/usr/bin/env python

import json
import sys

from subprocess import Popen, PIPE


def main():
    p = Popen(['i3-msg', '-t', 'get_workspaces'], stdout=PIPE)
    workspaces_json , _ = p.communicate()
    workspaces = json.loads(workspaces_json.decode())

    focused_workspace = next(x for x in workspaces if x['focused'])
    workspace_names = [x['name'] for x in workspaces]

    if len(sys.argv) < 2:
        for name in workspace_names:
            print(name)
    else:
        workspace = sys.argv[1].strip()

        if workspace and workspace != focused_workspace['name']:
            Popen(['i3-msg', 'workspace', workspace.strip()], stdout=PIPE)


if __name__ == '__main__':
    main()
