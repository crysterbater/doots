add(){
    GIT_DIR=$(dirname $(realpath -s $(git rev-parse --git-dir)))
    if [ "$GIT_DIR" != "" ]; then
        for file in $( git status --porcelain \
                     | awk -v GIT_DIR=$GIT_DIR '{print $1 " " GIT_DIR "/" $2 }' \
                     | awk '{"realpath -s --relative-to . " $2 | getline path; print $1 " " path}' \
                     | rofi -dmenu -sync -i -font "mono 6" -p 'git add:' \
                       -scroll-method 1 -lines 30 -matching glob \
                       -hide-scrollbar -line-margin 0 -multi-select \
                     | awk '{print $2}'); do
            git add $file
        done
    fi
}

commit(){
    GIT_DIR=$(dirname $(realpath -s $(git rev-parse --git-dir)))
    if [ "$GIT_DIR" != "" ]; then
        add
        git commit
    fi
}

fixup(){
    add
    sha=$( git log --oneline \
         | rofi -dmenu -sync -i -font "mono 6" -p 'git commit --fixup:' \
           -scroll-method 1 -lines 30 -matching glob \
           -hide-scrollbar -line-margin 0 \
         | awk '{print $1}')
    git commit --fixup $sha
}

show(){
    sha=$( git log --oneline \
         | rofi -dmenu -sync -i -font "mono 6" -p 'git show:' \
           -scroll-method 1 -lines 30 -matching glob \
           -hide-scrollbar -line-margin 0 \
         | awk '{print $1}')
    git show $sha
}

squash(){
    msg=$( git log --oneline | grep 'fixup!' | head -1 | sed 's/^[0-9a-f]*\s*fixup!\s*//' )
    sha=$( git log --oneline | grep "$MSG" | head -2 | tail -1 | awk '{print $1}' )
    git rebase -i --autosquash ${sha}~1
}

unstage(){
    GIT_DIR=$(dirname $(realpath -s $(git rev-parse --git-dir)))
    if [ "$GIT_DIR" != "" ]; then
        for file in $( git status --porcelain \
                     | grep -v "^??" \
                     | grep -v "^ " \
                     | awk '{print $2}' \
                     | xargs -n 1 printf "%s/%s\n" $GIT_DIR \
                     | xargs realpath -s --relative-to . \
                     | rofi -dmenu -sync -i -font "mono 6" -p 'git unstage:' \
                       -scroll-method 1 -lines 30 -matching glob \
                       -hide-scrollbar -line-margin 0 -multi-select); do
            git reset HEAD $file
        done
    fi
}

rsh(){
    host=$( cat ~/.ssh/config \
          | grep "^\s*Host\(Name\)\?" \
          | grep -v "\*" \
          | sed 's/^\s*//' \
          | awk '{print $2}' \
          | rofi -dmenu -sync -i -font "mono 6" -p 'ssh to:' \
            -scroll-method 1 -lines 30 -matching glob \
            -hide-scrollbar -line-margin 0 ) || return
    ssh $host
}

checkout(){
    branch=$({
                 git for-each-ref --sort=-committerdate refs/heads --format='%(objectname) B %(refname:short) %(upstream:short)%(upstream:trackshort) â %(contents:subject) â %(authorname) â (%(committerdate:relative))'
                 git for-each-ref --sort=-committerdate refs/remotes --format='%(objectname) R %(refname:short) %(upstream:short)%(upstream:trackshort) â %(contents:subject) â %(authorname) â (%(committerdate:relative))'
                 git for-each-ref --sort=-committerdate refs/tags --format='%(objectname) T %(refname:short) %(upstream:short)%(upstream:trackshort) â %(contents:subject) â %(authorname) â (%(committerdate:relative))'
             } | awk '!seen[$1]++ {for (i=2; i<NF; i++) printf $i " "; print $NF}' \
               | column -s "â" -t \
               | rofi -dmenu -sync -i -font "mono 6" -p 'git checkout:' \
                 -scroll-method 1 -lines 30 -width 80 -matching glob \
                 -hide-scrollbar -line-margin 0 ) || return

    branch=$(echo $branch | awk '{print $2}')
    final_branch=$branch
    for name in $(git remote); do
        prefix=${name}/
        if [[ "$branch" = ${prefix}* ]]; then
            final_branch=${branch#$prefix}
        fi
    done

    git checkout $final_branch
}


gitclean(){
    git remote prune origin
    git fetch --prune
    git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}


