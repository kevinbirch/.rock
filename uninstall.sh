#!/usr/bin/env bash

VERBOSE=0
DRY_RUN=0

DIR=$(cd $(dirname $0); pwd -P)

function usage
{
    cat <<EOF
usage: $(basename $0) [options]

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
    else
        echo "$@"
    fi
}

function disconnect
{
    if [ -e ~/.${1}\~ ] && [ -L ~/.${1} ]; then
        say "replacing ~/.${1} with backup"
        if [ -d ~/.${1}\~ ]; then
            maybe rm ~/.${1}
        fi
        maybe mv ~/.${1}\~ ~/.$1
    elif [ -L ~/.${1} ]; then
        say "removing link for ~/.${1}"
        maybe rm ~/.${1}
    fi

}

function disconnect-dir
{
    for f in $(ls $1)
    do
        disconnect $f
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
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            exit 1
            ;;
    esac
done

cd $DIR

say "unlinking common files"
disconnect-dir common

# get the OS name in portable way, make it lower case and drop everything after an underscore or dash
OS=$(uname -s | tr "[:upper:]" "[:lower:]" | sed 's/\([^-_]*\)[-_].*/\1/')

say "unlinking platform specific files"
if [ -d plaf/$OS ]; then
    disconnect-dir plaf/$OS
fi

disconnect emacs
disconnect vimrc

