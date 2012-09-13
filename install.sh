#!/bin/sh

DIR=$(dirname $0)

function connect
{
    if [ -e $2 ]; then
        mv $2 "$2~"
    fi
    ln -s $1 $2
}

DOTS="MacOSX alias bash_logout bash_profile bashrc config dircolors environment gitconfig gitk inputrc profile sbclrc screenrc"

cd $DIR

for f in $DOTS
do
    if [ -f $1 ]; then
        connect $f ~/.$f
    fi
done

connect ~/.emacs.d/init.el ~/.emacs
connect ~/.vim.d/vimrc ~/.vimrc

read -e -p "Enter email [$USER@$HOSTNAME]: " email
test -z $email && email="$USER@$HOSTNAME"

git config --file ~/.gitconfig.host user.email $email


