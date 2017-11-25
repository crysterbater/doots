function railsdir() {
  cd ~/rails/$1
}

function makedir() {
  mkdir $1
  cd $1
}

function gitadd() {
  echo 'adding all files'
  git add .
  echo 'add commit message'
    read message
    git commit -am "$message"
}
