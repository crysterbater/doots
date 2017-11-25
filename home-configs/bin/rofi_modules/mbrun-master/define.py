#!/bin/env python3

from sys import argv,exit
from subprocess import Popen, PIPE
from helpers import mbrofi

# user variables

# application variables
mbconfig = mbrofi.parse_config()
dictionary_file = 'dictd_www.dict.org_gcide'
thesaurus_file = 'Moby Thesaurus II'
BIND_TOGGLE = 'alt-t'
rofi_lines = None
script_ident = 'define'
if script_ident in mbconfig:
    dictionary_file = mbconfig[script_ident].get("dictionary_file"
                                        , fallback='dictd_www.dict.org_gcide')

    thesaurus_file = mbconfig[script_ident].get("thesaurus_file"
                                        , fallback='Moby Thesaurus II')
    BIND_TOGGLE = mbconfig[script_ident].get("bind_toggle", fallback="alt-t")
    rofi_lines = mbconfig[script_ident].get("rofi_lines", fallback=None)

# launcher variables
prompt = "define:"
filt=""

# run correct launcher with prompt and help message
launcher_args = {}
launcher_args['prompt'] = prompt
launcher_args['filter'] = filt
launcher_args['format'] = 'f'
launcher_args['bindings'] = [BIND_TOGGLE]

def define(word, thesaurus=False):
    """Send word to sdcv dictionary and return results"""
    if thesaurus:
        proc = Popen(['sdcv', '-n', '-u', thesaurus_file, word], stdout=PIPE)
    else:
        proc = Popen(['sdcv', '-n', '-u', dictionary_file, word], stdout=PIPE)
    ans = proc.stdout.read().decode('utf-8')
    exit_code = proc.wait()
    if exit_code == 1:
        print("sdcv failed...exiting")
        exit(1)
    else:
        entries = []
        templist = ans.strip().split('\n')
        for entry in templist:
            if entry.startswith('-'):
                continue
            entries.append(entry)
        return(entries)


def main(launcher_args, query=None, thesaurus=False):
    """Main function."""
    while True:
        if thesaurus:
            launcher_args['prompt'] = "thesaurus:"
        else:
            launcher_args['prompt'] = "define"
        if query is None:
                answer, exit_code = mbrofi.rofi([], launcher_args)
        else:
            if rofi_lines is None:
                answer, exit_code = mbrofi.rofi(define(query, thesaurus)
                                           , launcher_args, '-i')
            else:
                answer, exit_code = mbrofi.rofi(define(query, thesaurus)
                                           , launcher_args
                                           , ['-lines', str(rofi_lines), '-i'])
        if (exit_code == 1):
            break
        if not answer:
            if exit_code == 10:
                thesaurus = not(thesaurus)
                continue
            else:
                break
        elif (exit_code == 0):
            filt = answer.strip()
            query = filt
        elif (exit_code == 10):
            thesaurus = not(thesaurus)
            filt = answer.strip()
            query = filt
        else:
            break


if __name__ == '__main__':
    if (len(argv) > 1):
        if argv[1] == '-t':
            thesaurus = True
            query = ''.join(str(e) + ' ' for e in argv[2:]).strip()
        else:
            thesaurus = False
            query = ''.join(str(e) + ' ' for e in argv[1:]).strip()
        main(launcher_args, query, thesaurus)
    else:
        query = None
        main(launcher_args, query)
