main() {
  intro-message
  link-dotfiles
  outro-message
}

intro-message(){
  echo "This will prepare your local environment for using polybar."
  echo "Assuming that polybar and a compatible window manager is already installed"
  echo
}

function get-script-dir ()
{                                                                                                                    
    source="${BASH_SOURCE[0]}"
    while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
        dir="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        # if $source was a relative symlink, we need to resolve it relative
        # to the path where the symlink file was located
        [[ $source != /* ]] && source="$dir/$source"
    done
    dir="$( cd -P "$( dirname "$source" )" && pwd )"
    echo $dir
}

link-dotfiles(){
  echo "Linking dotfiles directory to expected .config location:"
  POLYBAR_DOTS_ROOT="$(get-script-dir)"
  POLYBAR_LINK="$HOME/.config/polybar"
  echo "$POLYBAR_LINK -> $POLYBAR_DOTS_ROOT"
  rm $POLYBAR_LINK &> /dev/null # ignore rm errors and output if file DNE
  ln -s $POLYBAR_DOTS_ROOT $POLYBAR_LINK
}

outro-message(){
  echo "...done!"
  echo "Here is the output of: ls -laG | grep -i polybar :"
  echo "Check that the link properly leads to the dotfiles path for polybar"
  ls -laG $HOME/.config | grep -i polybar
}

main
unset main
