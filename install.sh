#!/bin/bash

VERBOSE=0
DRY_RUN=0

DIR=$(dirname $0)

DOTS="MacOSX alias bash_logout bash_profile bashrc config dircolors environment gitconfig gitk inputrc profile sbclrc screenrc"

function usage
{
    cat <<EOF
usage: $(basename $0) [options]

    -e <email>    setting for gitconfig user.email (if this is given, you will not be prompted for it)
    -d            dry-run, do not make any changes (useful with verbose setting)
    -v            be verbose; explain each action to be taken

    -h            print this help message
EOF
}

function say
{
    if [ 1 -eq $VERBOSE ]; then
        echo $1
    fi
}

function maybe
{
    if [ 0 -eq $DRY_RUN ]; then
        eval $@
    fi
}

function connect
{
    if [ -e $2 ]; then
        say "backing up existing file: $2"
        maybe mv $2 "$2~"
    fi
    say "linking $2 -> $1"
    maybe ln -s $1 $2
}

while getopts "hvde:" opt; do
    case $opt in
        v)
            VERBOSE=1
            ;;
        d)
            DRY_RUN=1
            ;;
        e)
            email=$OPTARG
            ;;
        h)
            usage
            exit 0
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            exit 1
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            exit 1
            ;;
    esac
done

cd $DIR

for f in $DOTS
do
    if [ -e $f ]; then
        connect "$(pwd)/$f" ~/.$f
    fi
done

say "taking an excursion to $HOME"
pushd ~ > /dev/null
connect .emacs.d/init.el .emacs
connect .vim/vimrc .vimrc
say "returning from excursion"
popd > /dev/null

if [ -z "$email" ]; then
    read -e -p "Enter email [$USER@$HOSTNAME]: " email
    test -z $email && email="$USER@$HOSTNAME"
fi

say "setting up ~/.gitconfig.host with user.email=$email"
maybe git config --file ~/.gitconfig.host user.email $email


