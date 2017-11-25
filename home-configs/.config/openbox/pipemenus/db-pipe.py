#!/usr/bin/env python

import xml.etree.ElementTree as ET
from subprocess import run as _run, PIPE
import os

playlist_extensions = ['.dbpl']
playlists = []


# Convenience function for throwing away the 'starting deadbeef' string
def run(cmd, **args):
    return _run(cmd, stdout=PIPE, stderr=PIPE, **args)


def query_deadbeef(fmt):
    cp = run(['deadbeef', '--nowplaying-tf', '%isplaying%'+fmt])
    s = str(cp.stdout, 'utf-8')
    if s.startswith('1'):
        return s[1:]
    else:
        return '[cricket sounds]'


def is_alivebeef():
    return run('ps -e -o command | grep ^deadbeef', shell=True).returncode == 0


def create_element(tag, parent=None, **attrs):
    if parent is None:
        return ET.Element(tag, **attrs)
    return ET.SubElement(parent, tag, **attrs)


def create_playlists(parent):
    for filename, full_path in playlists:
        name, ext = os.path.splitext(filename)
        if ext in playlist_extensions:
            create_cmd_action(
                create_element('item', parent=parent, label=name),
                'deadbeef "%s"' % full_path)


def create_cmd_action(item, command):
    act_e = create_element('action', parent=item, name='Execute')
    act_cmd = create_element('command', parent=act_e)
    act_cmd.text = command


if __name__ == '__main__':
    from sys import argv

    # dirty arg parser
    if '-p' in argv:
        pld, _, pls = next(os.walk(argv[argv.index('-p')+1]))
        for e in pls:
            playlists.append((e, os.path.join(pld, e)))

    top = create_element('openbox_pipe_menu')

    def item(**a):
        return create_element('item', parent=top, **a)

    running = is_alivebeef()  # to avoid calling run repeatedly
    if running:
        display_str = query_deadbeef('%artist% - %title%')
        create_element('separator', parent=top, label=display_str)
        create_cmd_action(item(label='play/pause'), 'deadbeef --play-pause')
        create_cmd_action(item(label='next'),       'deadbeef --next')
        create_cmd_action(item(label='prev'),       'deadbeef --prev')
        create_cmd_action(item(label='random'),     'deadbeef --random')
        create_cmd_action(item(label='stop'),       'deadbeef --stop')

    else:
        create_element('separator', parent=top, label='deadbeef is dead')
        create_cmd_action(item(label='launch'), 'deadbeef')

    # if we have a playlist dir, let us select entries from it
    if playlists:
        if running:
            create_element('separator', parent=top)
            pl_menu = create_element('menu', parent=top, label='playlists', id='_pl')
        else:
            create_element('separator', parent=top, label='playlists')
            pl_menu = top
        create_playlists(pl_menu)

    if running:
        create_element('separator', parent=top)
        create_cmd_action(item(label='quit'), 'deadbeef --quit')

    ET.dump(top)
