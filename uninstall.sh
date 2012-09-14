#!/bin/bash

VERBOSE=0
DRY_RUN=0

DOTS="MacOSX alias bash_logout bash_profile bashrc config dircolors environment gitconfig gitk inputrc profile sbclrc screenrc"

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

cd ~

for f in $DOTS
do
    if [ -e .${f}\~ ] && [ -L .${f} ]; then
        say "replacing .${f} with backup"
        if [ -d .${f}\~ ]; then
            maybe rm .${f}
        fi
        maybe mv .${f}\~ .$f
    elif [ -L .${f} ]; then
        say "removing link for .${f}"
        maybe rm .${f}
    fi
done


