#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

promptTime="\n\[$(tput sgr0)\]\[\033[38;5;8m\]\D{%Y-%m-%d} \@\[$(tput sgr0)\]"
promptDir="\n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\]"
promptGit="\n\[$(tput sgr0)\]\[\033[38;5;6m\]\[\$(git symbolic-ref --short HEAD 2>/dev/null)\]"
promptEnd="\n\[$(tput sgr0)\]\[\033[38;5;8m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

PS1=$promptTime$promptDir$promptGit$promptEnd