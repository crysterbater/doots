#!/bin/env python3

from sys import argv,exit
from subprocess import Popen, PIPE
from helpers import mbrofi

# user variables

# application variables
mbconfig = mbrofi.parse_config()
thesaurus_file = 'Moby Thesaurus II'
rofi_lines = None
script_ident = 'thesaurus'
if script_ident in mbconfig:
    thesaurus_file = mbconfig[script_ident].get("thesaurus_file"
                                        , fallback='Moby Thesaurus II')
    rofi_lines = mbconfig[script_ident].get("rofi_lines", fallback=None)

print(thesaurus_file)

# launcher variables
prompt = "define:"
filt=""

# run correct launcher with prompt and help message
launcher_args = {}
launcher_args['prompt'] = prompt
launcher_args['filter'] = filt
launcher_args['format'] = 'f'

def define(word):
    """Send word to sdcv dictionary and return results"""
    proc = Popen(['sdcv', '-n', '-u', thesaurus_file, word], stdout=PIPE)
    ans = proc.stdout.read().decode('utf-8')
    exit = proc.wait()
    if exit == 1:
        print("sdcv failed...exiting")
        sys.exit(1)
    else:
        entries = []
        templist = ans.strip().split('\n')
        for entry in templist:
            if entry.startswith('-'):
                continue
            entries.append(entry)
        return(entries)


def main_rofi_function(launcher_args, query=None):
    """Call main rofi function and return the selection, filter, selection
    index, and exit code. Don't return any of these in case of rofi being 
    escaped.
    """
    if query is None:
        answer, exit = mbrofi.rofi([], launcher_args)
    else:
        if rofi_lines is None:
            answer, exit = mbrofi.rofi(define(query), launcher_args)
        else:
            answer, exit = mbrofi.rofi(define(query), launcher_args
                                   , ['-lines', str(rofi_lines), '-i'])
    if exit == 1:
        return(None, 1)
    filt = answer.strip()
    return(filt, exit)




def main(launcher_args, query=None):
    """Main function."""
    while True:
        filt, exit = main_rofi_function(launcher_args, query)
        if (exit == 0):
            query = filt
        elif (exit == 1):
            # This is the case where rofi is escaped (should exit)
            break
        else:
            break


if __name__ == '__main__':
    if (len(argv) > 1):
        query = ''.join(str(e) + ' ' for e in argv[1:]).strip()
        main(launcher_args, query)
    else:
        query = None
        main(launcher_args, query)
