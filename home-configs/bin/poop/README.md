# Poop

My Simple tool for backing up config files & folders written in bash.
Uses git for backing up.
# Why the name "Poop"?

Because i'm uncreative, and can't think of anything better.

# How to use/what does what do

It has two commands at the time of writing: "dump", and "flush".
Dump is used to add files to the backup list, located in /home/(username)/my-stuff. Because i'm quite new to bash scripting, it currently only supports 20 files/folders (you can change this, but it will use a lot more lines in the script). Flush uses the files listed in the backup list to copy over the files to /home/(username)/my-stuff, add them in to the git commit, then push to your repo.

# How to setup

1. Put the script itself somewhere convenient and make it executable
2. Make a directory called "my-stuff" in your home dir. Create a git repo inside.
3. You should (hopefully) be done!
