#
# prompt.sh
#

promptTime="\n\[$(tput sgr0)\]\[\033[38;5;8m\]\D{%Y-%m-%d} \@\[$(tput sgr0)\]"
promptDir="\n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\]"
promptGit="\n\[$(tput sgr0)\]\[\033[38;5;6m\]\[\$(git symbolic-ref --short HEAD 2>/dev/null)\]"
promptHostDirGit="\n\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]"
promptEnd="\n\[$(tput sgr0)\]\[\033[38;5;8m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
PS1=$promptTime$promptHostDirGit$promptEnd
