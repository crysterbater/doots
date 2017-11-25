#!/usr/bin/env python3
import os
from shutil import copyfile
from glob import glob
from mando import command, main
from subprocess import call
from time import strftime
# Handy variables
HOME = os.environ['HOME']
EDITOR = os.environ.get('EDITOR','vim')
config_path = HOME + '/.config/termite/'
files = glob(config_path + '/*')
iso_date = strftime("%H:%M:%S")

@command
def list():
    '''List available configurations'''
    for file in files:
        print(os.path.basename(file))

@command
def edit(file):
    '''Edit config files'''
    call([EDITOR, config_path + file])


@command
def backup(file):
    '''Backup config files'''
    copyfile(config_path + file, config_path + file + '.bak')
    print(file + ' is now backed up.')

@command
def delete(file):
    '''Delete (and, optionally, backup) config files'''
    answer = input('Should I make a backup before? (y/n)')
    if answer == 'y':
        backup(file)
        os.remove(config_path + file)
        print(file + ' is now gone.')
    else:
        os.remove(config_path + file)
        print(file + ' no longer exists.')

@command
def new(file):
    '''Creates a new config file from the current one'''
    copyfile(config_path + 'config', config_path + file)
    call([EDITOR, config_path + file])

@command
def change(file):
    '''Change to config file'''
    try:
        os.rename(config_path + 'config', config_path + 'config' + iso_date)
    except:
        pass
    os.rename(config_path + file, config_path + 'config')
    print('Current config file is now ' + file)

if __name__ == '__main__':
main()
