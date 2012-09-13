# -*- shell-script -*-
# .bashrc - dot rockin' it on the C-to-the-L-to-the-I

if [ -z "$PS1" ]; then
	return
fi

if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
elif [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.environment ]; then
	. ~/.environment
fi

if [ -f ~/.environment.host ]; then
	. ~/.environment.host
fi

if [ -f ~/.alias ]; then
	. ~/.alias
fi

if [ -e ~/.alias.host ]; then
	. ~/.alias.host
fi

if [ -f ~/.dircolors ]; then
	eval `dircolors -b ~/.dircolors`
fi

function up
{
    for (( i = 0; i < ${#1}; i = i + 1 )) ; do 
        if [ $i -eq 0 ]; then 
            p=".."
        else
            p="$p/.."
        fi
    done
    if [ -z "$p" ]; then
        return
    fi
    cd $p
}

function extract
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1    ;;
            *.tar.gz)    tar xzf $1    ;;
            *.bz2)       bunzip2 $1    ;;
            *.rar)       rar x $1      ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1     ;;
            *.tbz2)      tar xjf $1    ;;
            *.tgz)       tar xzf $1    ;;
            *.zip)       unzip $1      ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1       ;;
            *)           echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

