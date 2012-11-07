#!/usr/bin/env bash

VERBOSE=0
DRY_RUN=0

DIR=$(cd $(dirname $0); pwd -P)

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
        eval $@ > /dev/null
    else
        echo "$@"
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

function connect-dir
{
    for f in $(ls $1)
    do
        connect $1/$f ~/.$f
    done
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

say "linking common files"
connect-dir $DIR/common

say "linking platform specific files"
# get the OS name in portable way, make it lower case and drop everything after an underscore or dash
OS=$(uname -s | tr "[:upper:]" "[:lower:]" | sed 's/\([^-_]*\)[-_].*/\1/')

if [ -d plaf/$OS ]; then
    connect-dir $DIR/plaf/$OS
fi

say "taking an excursion to $HOME"
maybe pushd ~
connect .emacs.d/init.el .emacs
connect .vim/vimrc .vimrc
say "returning from excursion"
maybe popd

say "fixing up quicklisp client pointers"
maybe pushd $DIR/common/lisp/quicklisp
connect ../quicklisp-client quicklisp
say "done"
maybe popd

if [ -z "$email" ]; then
    read -e -p "Enter email [$USER@$HOSTNAME]: " email
fi

say "setting up ~/.gitconfig.host with user.email=$email"
maybe git config --file ~/.gitconfig.host user.email ${email:-$USER@$HOSTNAME}


