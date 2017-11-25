#!/bin/env python3

import os
import sys
from subprocess import Popen, PIPE
from datetime import datetime, date, time

from helpers import mbrofi
import screenshots

# user variables
upload = False
screenshot_directory='~/Pictures/screenshots/'
BIND_DELAY = 'alt-d'
BIND_UPLOAD = 'alt-u'
BIND_INTERACTIVE = 'alt-i'
ENTRY_ORDER = ['selection', 'all', 'displays']
entry_order = None
maim_bordersize="3"
maim_color="0.7,0.3,0.7,1.0"
script_id = 'sshot'
mbconfig = mbrofi.parse_config()
if script_id in mbconfig:
    lconf = mbconfig[script_id]
    screenshot_directory = lconf.get("screenshot_directory"
                                        , fallback='~/Pictures/screenshots')
    upload = lconf.getboolean("upload", fallback=False)
    BIND_DELAY = lconf.get("bind_delay", fallback='alt-d')
    BIND_UPLOAD = lconf.get("bind_upload", fallback='alt-u')
    BIND_INTERACTIVE = lconf.get("bind_interactive", fallback='alt-i')
    maim_bordersize = lconf.get("maim_bordersize", fallback="3")
    maim_color = lconf.get("maim_color", fallback="0.7,0.3,0.7,1.0")
    t_entry_order = lconf.get("entry_order", fallback='selection,all,displays')
    entry_order = []
    for e in t_entry_order.split(','):
        entry_order.append(e.strip())

# application variables
MAIM_SELECTION_SETTINGS = ['--bordersize=' + maim_bordersize
                           , '--color=' + maim_color]
valid_entries = ['displays', 'all', 'selection']
good_order = True
if entry_order is not None:
    for entry in entry_order:
        if entry not in valid_entries:
            good_order=False
    if good_order:
        ENTRY_ORDER = entry_order
    else:
        print("Bad entry_order. Use 'displays', 'all' and 'selection', "
            + "separated by commas. (e.g., displays,all,selection)."
            + " Using default order.")
        ENTRY_ORDER = ['selection', 'all', 'displays']

# launcher variables
bindings = ["alt+h"]
bindings += [BIND_DELAY]
bindings += [BIND_UPLOAD]
bindings += [BIND_INTERACTIVE]

BIND_HELPLIST = ["Show help menu."]
BIND_HELPLIST += ["Add a delay using a rofi submenu."]
BIND_HELPLIST += ["Toggle uploading to ptpb.pw."]
BIND_HELPLIST += ["Take screenshot, and run screenshots.py to manage the screenshot"]
msg = "Description of template. "
msg += bindings[0] + " to show help."
#msg = "Help text. " + bindings[0] + " does something, " +  \
        #bindings[1]  + " does something else."
prompt_name = "sshot"
answer=""
sel=""
filt=""
index=0
SCREENSHOT_DIRECTORY = os.path.expanduser(screenshot_directory)

if not (os.path.isdir(SCREENSHOT_DIRECTORY)):
    print('Creating ' + SCREENSHOT_DIRECTORY + '...')
    os.makedirs(SCREENSHOT_DIRECTORY)

# run correct launcher with prompt and help message
launcher_args = {}
launcher_args['prompt'] = prompt_name + ":"
launcher_args['mesg'] = msg
launcher_args['filter'] = filt
launcher_args['bindings'] = bindings
launcher_args['index'] = index

def sshot(opt_name, opt_type, opt_geom, delay=0):
    """Take screenshot and return the image name.

    Keyword arguments:
    opt_name -- name of option (selection, all, <display name>
    opt_type -- type of option (selection, all, display) 
    opt_geom -- geometry of option (only useful for displays
    delay -- int with delay in seconds (default 0)
    """
    date = datetime.now()
    imgname = "sshot-" + date.strftime('%Y-%m-%d_%H:%M:%S') + ".png"
    imgloc = os.path.join(SCREENSHOT_DIRECTORY, imgname)
    command = ['maim']
    if (delay > 0):
        command.extend(['-d', str(delay)])

    if opt_type == "all":
        pass
    elif opt_type == "selection":
        command.extend(MAIM_SELECTION_SETTINGS)
        command.append('-s')
    elif opt_type == "display":
        command.extend(['-g', opt_geom])

    command.append(imgloc)

    proc = Popen(command, stdout=PIPE)
    ans = proc.stdout.read().decode('utf-8')
    exit_code = proc.wait()
    if exit_code == 0:
        return(imgname)
    else:
        return(False)

def generate_entries(options, delay=0):
    """generate entries to show in rofi from a list of options"""
    entries = []
    for opt in options:
        if int(delay) > 0:
            opt += " (" + str(delay) + "s delay)"
        entries.append(opt)
    return(entries)


def get_options():
    """Get a list of options"""
    entries = []
    types = []
    geometries = []
    for E in ENTRY_ORDER:
        if (E == 'displays'):
            displays, disp_geoms = get_displays()
            d_ct = 0
            for disp in displays:
                entries.append(disp)
                types.append('display')
                geometries.append(disp_geoms[d_ct])
                d_ct += 1
        elif (E == 'all'):
            e = 'all'
            entries.append(e)
            types.append('all')
            geometries.append(None)
        elif (E == 'selection'):
            e = 'selection'
            entries.append(e)
            types.append('selection')
            geometries.append(None)
    return(entries, types, geometries)


def get_displays():
    proc = Popen(['xrandr'], stdout=PIPE)
    ans = proc.stdout.read().decode('utf-8')
    exit = proc.wait()
    dlist = []
    glist = []
    for entry in ans.strip().split('\n'):
        if ' connected' in entry:
            d = entry.split()
            dlist.append(d[0].strip())
            glist.append(d[2].strip())
    return(dlist, glist)


def add_delay(delay_binding):
    """Show rofi menu to set a delay, and return the result as a string."""
    local_launcher_args = {}
    local_launcher_args['mesg'] = "Choose delay, or write custom one."
    local_launcher_args['mesg'] += " Press " + delay_binding + " to go back."
    local_launcher_args['prompt'] = "sshot (add delay):"
    local_launcher_args['format'] = "s"
    local_launcher_args['bindings'] = [delay_binding]
    delay, exit = mbrofi.rofi(["5","4","3","2","1","0"], local_launcher_args)
    if exit == 1:
        print("sshot.py delay menu was escaped, and right now" \
              + " this is set to abort the top script. This is expected " \
              + "behavior. Use '" + delay_binding + "' to go back to the" \
              + " main menu.")
        sys.exit(0)
    elif exit == 0:
        delay = delay.strip()
        try:
            d = int(delay)
            return(int(delay))
        except ValueError:
            return(None)
    else:
        return(None)


def main_rofi_function(launcher_args, entries, delay):
    """Call main rofi function and return the selection, filter, selection
    index, and exit code. Don't return any of these in case of rofi being 
    escaped.
    """
    return(index, filt, sel, exit)


def main(launcher_args, upload):
    """Main function."""
    delay = 0
    opts, types, geoms = get_options()
    while True:
        entries = generate_entries(opts, delay)
        if upload:
            launcher_args['prompt'] = prompt_name + '(upload):'
        else:
            launcher_args['prompt'] = prompt_name + '(noupload):'
        # Run rofi and parse output
        answer, exit = mbrofi.rofi(entries, launcher_args, ['-i'])
        if exit == 1:
            return(False, False, False, 1)
        index, filt, sel = answer.strip().split(';')
        launcher_args['filter'] = filt
        launcher_args['index'] = index
        selected_opt = opts[int(index)]
        selected_type = types[int(index)]
        selected_geom = geoms[int(index)]
        if (exit == 0):
            imgname = sshot(selected_opt, selected_type, selected_geom, delay)
            if upload and imgname:
                pasteurl = mbrofi.upload_ptpb(SCREENSHOT_DIRECTORY, imgname
                                        , notify_bool=True, name="Screenshot")
                if pasteurl:
                    pasteurl = pasteurl.strip()
                    mbrofi.clip(pasteurl)
            break
        elif (exit == 1):
            # This is the case where rofi is escaped (should exit)
            break
        elif (exit == 10):
            """show help"""
            mbrofi.rofi_help(bindings, BIND_HELPLIST)
        elif (exit == 11):
            """add delay"""
            tmp_delay = add_delay(BIND_DELAY)
            if tmp_delay is not None:
                delay = tmp_delay
        elif (exit == 12):
            """toggle upload"""
            upload = (not upload)
        elif (exit == 13):
            """interactive mode"""
            imgname = sshot(selected_opt, selected_type, selected_geom, delay)
            if imgname:
                screenshots.main()
            break
        else:
            break


if __name__ == '__main__':
    if (len(sys.argv) == 1):
        main(launcher_args, upload)

