#!/bin/env python3

import os
from helpers import mbrofi

# user variables

# application variables
bookmark_directory='~/bookmarks/'

BIND_NEW = 'alt-n'
script_id = 'bookmarks'
mbconfig = mbrofi.parse_config()
if script_id in mbconfig:
    lconf = mbconfig[script_id]
    bookmark_directory = lconf.get("bookmark_directory"
                                        , fallback='~/bookmarks/')
    BIND_NEW = lconf.get('bind_new', fallback='BIND_NEW')
BOOKMARK_DIRECTORY = os.path.expanduser(bookmark_directory)

bindings = ["alt+h"]

# launcher variables
msg = "Press Enter to open bookmark. "
msg += bindings[0] + " to show help."
#msg = "Help text. " + bindings[0] + " does something, " +  \
        #bindings[1]  + " does something else."
prompt = "bookmarks:"
answer=""
sel=""
filt=""
index=0

# run correct launcher with prompt and help message
launcher_args = {}
launcher_args['prompt'] = prompt
launcher_args['mesg'] = msg
launcher_args['filter'] = filt
launcher_args['bindings'] = bindings
launcher_args['index'] = index


def check_url():
    pass


def list_bookmarks():
    pass


def add_bookmark(name, url):

    book_path = os.path.join(BOOKMARK_DIRECTORY, name)
    print('name: ' + name)
    print('url: ' + url)
    print('path: ' + book_path)
    if os.path.isfile(book_path):
        print("Bookmark '" + book_path + "' was found...ignoring 'add'")
        return(False)

    bookfile = open(book_path, 'w')
    bookfile.write(url.strip())
    bookfile.close()


def rm_bookmark():
    pass


def edit_bookmark():
    pass


def open_bookmark(name):
    book_path = os.path.join(BOOKMARK_DIRECTORY, name)
    print('name: ' + name)
    print('path: ' + book_path)
    if not os.path.isfile(book_path):
        print("Bookmark '" + name + "' was not found...ignoring 'open'")
        return(False)

    bookfile = open(book_path, 'r')
    url = bookfile.readline()
    bookfile.close()
    print('url: ' + url)
    #mbrofi.xdg_open(



def list_entries():
    """Get list of entries to be displayed via rofi."""
    return(['a', 'b', 'bb', 'c'])


def main_rofi_function(launcher_args):
    """Call main rofi function and return the selection, filter, selection
    index, and exit code. Don't return any of these in case of rofi being 
    escaped.
    """
    answer, exit = mbrofi.rofi(list_entries(), launcher_args)
    if exit == 1:
        return(False, False, False, 1)
    index, filt, sel = answer.strip().split(';')
    return(index, filt, sel, exit)


def main(launcher_args):
    """Main function."""
    while True:
        index, filt, sel, exit = main_rofi_function(launcher_args)
        launcher_args['filter'] = filt
        launcher_args['index'] = index
        if (exit == 0):
            # This is the case where enter is pressed
            print("Main function of the script.")
            break
        elif (exit == 1):
            # This is the case where rofi is escaped (should exit)
            break
        elif (exit == 10):
            helpmsg_list = []
            helpmsg_list.append('help menu.')
            mbrofi.rofi_help(bindings, helpmsg_list, prompt='bookmarks help:')
        elif (exit == 11):
            # What to do if second binding is pressed
            print(bindings[1] + " was pressed!")
        elif (exit == 12):
            # What to do if second binding is pressed
            print(bindings[2] + " was pressed!")
        else:
            break


if __name__ == '__main__':
    if not os.path.isdir(BOOKMARK_DIRECTORY):
        print("Bookmark directory does not exist at '" + BOOKMARK_DIRECTORY
                + "', creating it...")
        os.makedirs(BOOKMARK_DIRECTORY)
    #main(launcher_args)
    print('add')
    print('---')
    add_bookmark('hello', 'world')
    print()
    print('open')
    print('----')
    open_bookmark('hello')
