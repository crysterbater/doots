#!/usr/bin/env bash


#
##
####  Dotfile Backup and Restore script based around Git
####  Written by Nathaniel Maia <natemaia10@gmail.com>
##
#
#
#                     !! IMPORTANT !!
#
# Sensitive information & files should NEVER be backed up using git
# Passwords, Personal info, ~/.gnupg/, ~/.ssh, ~/.git-credentials, ~/.git
#
#################################################################################
#################################################################################
#
##
####  User configuration area
##
#

# git repo http address
# empty will skip git steps and only be a local backup
repo="https://github.com/crysterbater/doots"
branch="master"

# $dest and $repo folder MUST match if using git. Eg. my-dots = my-dots
# if not using git it doesn't matter
dest="/home/pringle/doots"

# main folder made in $dest/
home_dest="Configs"

# additional folder made in $dest/$home_dest/
# to be created if rootPaths() is NOT empty
root_dest="root-configs"


# homePaths will be stored in $dest/$home_dest/
# this array IS NEEDED, further arrays are NOT NEEDED
homePaths=($HOME/bin
           $HOME/.zshrc
           $HOME/.vimrc
           $HOME/.bashrc
           $HOME/.spacemacs
           $HOME/.gitconfig
           $HOME/startpage
           $HOME/scripts
           $HOME/.themes
           $HOME/.gorice
           $HOME/.profile
           $HOME/.gtkrc-2.0
           $HOME/.Xresources
           $HOME/.Xresources.template
           $HOME/.ncmpcpp
           $HOME/.mpd
           $HOME/.atom/config.cson
           $HOME/.oh-my-zsh/themes
           $HOME/.oh-my-zsh/custom
          )


# items in $HOME/.config
# done to limit what from ~/.config is backed up
# if doing local backup (not git), add $HOME/.config
# to the homePaths array and remove this.. your choice
configPaths=($HOME/.config/i3
             $HOME/.config/cava
             $HOME/.config/geany
             $HOME/.config/dunst
             $HOME/.config/Thunar
             $HOME/.config/ranger
             $HOME/.config/gtk-3.0
             $HOME/.config/termite
             $HOME/.config/compton
             $HOME/.config/polybar
             $HOME/.config/surfraw
             $HOME/.config/nitrogen
             $HOME/.config/neofetch
             $HOME/.config/fontconfig
             $HOME/.config/mimeapps.list
             $HOME/.config/compton.conf
             $HOME/.config/.composite_enabled
            )


# rootPaths will be stored in $dots/$home_dest/$root_dest
# I use it to keep configs and changes made to /etc/
# you may remove this if ONLY backing up files from $HOME
rootPaths=(/etc/X11
           /etc/makepkg.conf
           /etc/mpd.conf
           /etc/pacman.conf
           /etc/yaourtrc
          )



#################################################################################
#################################################################################
#
##
###  Messages & Colours
##
#

# colours
b='\E[1;34m'
r='\E[1;31m'
g='\E[1;32m'
norm='\E[0m'

# messages
warn="${r}[WARN]${norm}:"
info="${b}[INFO]${norm}:"
skip="${b}Skipping${norm}"
pass="${g}Passed!${norm}"
exit="${r}Exiting${norm}"
continue="${b}Continuing${norm}"
install="${b}Installing${norm}"

# combine the arrays
masterArray=(${rootPaths[@]} ${configPaths[@]} ${homePaths[@]})


USAGE="USAGE:
\n\tconfig-backup [OPTION]
\n\nOPTIONS:
\n\t-h.--help\tThis usage message
\n\t-r,--restore\tRestore files to original location
\n\t-b,--backup\tBackup files and sync with repo if chosen
\n\tWith no options the script prints this usage message"

#################################################################################
#################################################################################
#
##
###  Functions
##
#



# called by main function
# sets up folders where files will be copied
setupDirs() {

    clear

    # see if using git, install if yes but not installed
    # clone repo if using git and not already on drive
    checkGit

    # ask to clean up dest
    cleanDest

    # make rootPaths backup dir
    if [ ${#rootPaths[@]} -gt 0 ] && ! [ -d "$dest/$home_dest/$root_dest" ]; then
        mkdir -p "$dest/$home_dest/$root_dest"

    else
        echo -e "$info Check $dest/$home_dest/$root_dest exists... $pass"
        sleep 0.5

    fi

    # make base backup dir
    if ! [ -d "$dest/$home_dest/home/.config" ]; then
        mkdir -p "$dest/$home_dest"/home/.config

    else
        echo -e "$info Check $dest/$home_dest/home/.config exists... $pass"
        sleep 0.5

    fi

}




# ask to clean $dest/home_dest
cleanDest() {

    doClean() {

        if [ -d "$dest/$home_dest" ]; then
            echo -e "$info Cleaning $dest/$home_dest/"
            sleep 0.5
            rm -rf "$dest/$home_dest"

        else
            echo -e "$warn $dest/$home_dest not found...  $skip"
            sleep 0.5

        fi

    }

    printf "\n\nClean ALL Files in $dest/$home_dest ? [y/N]:"
    read -r do_clean

    case $do_clean in
        y|Y|Yes|yes)
            doClean
            ;;
        *)
            echo -e "$info Cleaning $dest/$home_dest... $skip"
            sleep 0.5
    esac

}




#check git is installed
checkGit() {

    if [ ${#repo} -gt 0 ] && ! hash git > /dev/null 2>&1; then
        echo -e "$info Git not Installed... $install"
        sleep 0.5
        sudo pacman -S git --noconfirm --needed

    elif [ ${#repo} -gt 0 ]; then
        echo -e "$info Git is Installed... $continue"
        sleep 0.5

    else
        echo -e "$info Not Using Git... $continue"

    fi


    # check $dest (a.k.a $repo) exists
    if ! [ -d "$dest" ] && [ ${#repo} -gt 0 ]; then  # using git
        git clone "$repo" "$dest"

    elif ! [ -d "$dest" ]; then                      # not using git
        mkdir -p "$dest"

    else                                             # dir exists
        echo -e "$info Check $dest exists... $pass"
        sleep 0.5

    fi

}




pushRepo() {

    doPush() {

        if [ -d "$dest" ]; then
            cd "$dest/"
        else
            echo -e "$warn $dest Not Found... $exit"
            exit 1
        fi

        clear
        echo -e "#\n##\n####  Enter Your comment describing this commit\n##\n#\n\n\n"
        printf "Commit: "
        read -r comment

        # make commit
        git add .
        git commit -m "$comment"
        git push origin "$branch"

    }


    # check if we're using git
    if [ ${#repo} -gt 0 ]; then
        # ask if we want to commit & push changes
        printf "Commit & Push Changes to $repo ? [y/N]:"
        read -r push_repo

        case $push_repo in
            y|Y|Yes|yes)
                doPush
                ;;
            *)
                :
        esac

    else
        echo -e "$info Not Using Git... $continue"

    fi

}


restoreFiles() {

    if [ -e "$dest/$home_dest/home/" ]; then
        cp -rf $dest/$home_dest/home/. $HOME/
    fi

    if [ -e "$dest/$home_dest/$root_dest" ]; then
        cp -rf $dest/$home_dest/$root_dest/. /etc/
    fi

    echo -e "$info Restore Complete... $exit"
    exit 0

}


# main function
doBackup() {

    # prep backup dirs
    setupDirs

    # for the counter
    num=1
    total=${#masterArray[@]}

    # do the backup
    for path in ${masterArray[@]}; do

        # check if it exists
        if [ -e "$path" ]; then
            case $path in
                */.config/*)
                    cp -rf $path $dest/$home_dest/home/.config/
                    ;;
                *oh-my-zsh*)
                    mkdir -p $dest/$home_dest/home/.oh-my-zsh
                    cp -rf $path $dest/$home_dest/home/.oh-my-zsh/
                    ;;
                *atom*)
                    mkdir -p $dest/$home_dest/home/.atom
                    cp -rf $path $dest/$home_dest/home/.atom/
                    ;;
                */home/*)
                    cp -rf $path $dest/$home_dest/home/
                    ;;
                *)
                    cp -rf $path $dest/$home_dest/$root_dest/
            esac

            echo -e "$info Copying $path... ${num}/${total}"

        else
            echo -e "$warn $path Not Found... ${num}/${total} $skip"

        fi

        # incriment the counter
        num=$(($num+1))
        sleep 0.1

    done

    # ask if we want to commit & push changes
    # only done if using git and $repo is set
    sleep 1; clear
    echo -e "\n\n$info Backup Complete!!\n\n"
    pushRepo

}


#################################################################################
#################################################################################
#
##
### End Functions
##
#


#################################################################################
#################################################################################

case $1 in
    -h|--help)
        echo -e $USAGE
        ;;
    -r|--restore)
        restoreFiles
        ;;
    -b|--backup)
        doBackup
        ;;
    *)
        echo -e $USAGE
esac



exit 0
