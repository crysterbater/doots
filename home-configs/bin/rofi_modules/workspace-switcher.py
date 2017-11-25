#!/usr/bin/env python3
import os
import subprocess
from collections import OrderedDict

from os.path import expanduser

import pprint


def show_rofi(prompt, items, number_items=True):
    rofi_input_string = ''
    formatted_items = OrderedDict()

    if type(items) == OrderedDict:
        for key, value in items.items():
            item_string = ''

            if number_items:
                number = list(items.keys()).index(key) + 1
                item_string += '%s. %s\n' % (number, value)
            else:
                item_string += '%s\n' % value

            rofi_input_string += item_string
            formatted_items[key] = item_string
    else:
        for item in items:
            item_string = ''

            if number_items:
                number = list(items).index(item) + 1
                item_string += '%s. %s\n' % (number, item)
            else:
                item_string += '%s\n' % item

            rofi_input_string += item_string
            formatted_items[item] = item_string


    prompt = '%s > ' % prompt

    echo_process = subprocess.Popen(["echo", rofi_input_string], stdout=subprocess.PIPE)
    rofi_process = subprocess.Popen(["rofi", "-p", prompt, "-dmenu"], stdin=echo_process.stdout, stdout=subprocess.PIPE)
    echo_process.stdout.close()
    stdout, stderr = rofi_process.communicate()
    result = stdout.decode()

    selected_index = list(formatted_items.values()).index(result)
    return list(formatted_items.keys())[selected_index]


def show_workspace_menu():
    home_dir = expanduser('~')

    workspace_config_path = os.path.join(home_dir, '.workspace-config')

    config_dirs = []
    for item in os.listdir(workspace_config_path):
        if os.path.isdir(os.path.join(workspace_config_path, item)):
            config_dirs.append(item)

    workspace = show_rofi('Choose Workspace', config_dirs)

    workspace_dir = os.path.join(workspace_config_path, workspace)

    if workspace is None:
        return

    show_workspace_action(workspace_dir)


def show_workspace_action(workspace_dir):
    actions = OrderedDict()

    actions['activate'] = 'A. Activate Configuration'
    
    if os.path.isfile(os.path.join(workspace_dir, 'monitor.sh')):
        actions['monitor.sh'] = 'M. Activate Monitor Configuration'

    if len(actions) > 0:
       action = show_rofi('Choose Action', actions, number_items=False)

    if action is None:
        return

    if action == "activate":
        activate_workspace(workspace_dir)
    else:
        run_action(os.path.join(workspace_dir, script))


def run_action(script_path):
    print("Try to run following script: %s" % script_path)
    subprocess.run([script_path], shell=True)
    

def activate_workspace(workspace_dir):
    for root, dirs, files in os.walk(workspace_dir):
        for script_file in files:
            if script_file in ["activate.sh", "deactivate.sh"]:
                pass
            else:
                run_action(os.path.join(workspace_dir, script_file))           

    
if __name__ == '__main__':
show_workspace_menu()
