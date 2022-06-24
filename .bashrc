#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Options
shopt -s checkwinsize # incase we are running on an older machine
shopt -s histappend

# Aliases
alias ls='ls --color=auto'
alias rm='rm -vI'
alias cp='cp -vi'
alias mv='mv -vi'

if [ $(uname) == "Linux" ]; then # we don't have macOS's 'open'
  alias open='xdg-open'
  export EDITOR=/usr/bin/nano
else # we are on macOS, so we need to set the right EDITOR
  export EDITOR=/usr/local/bin/nano
fi

## Special Software Aliases
alias tf='terraform'
alias tfi='tf init'
alias tff='tf fmt'
alias tfv='tf validate'
alias tfp='tf plan'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfo='tf output'

# Prompt
promptTime="\n\[$(tput sgr0)\]\[\033[38;5;8m\]\D{%Y-%m-%d} \@\[$(tput sgr0)\]"
promptDir="\n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\]"
promptGit="\n\[$(tput sgr0)\]\[\033[38;5;6m\]\[\$(git symbolic-ref --short HEAD 2>/dev/null)\]"
promptHostDirGit="\n\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]"
promptEnd="\n\[$(tput sgr0)\]\[\033[38;5;8m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
PS1=$promptTime$promptHostDirGit$promptEnd

# Exports
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:??:[ ]*:clear:exit:logout"
export PATH="/usr/local/bin:$PATH" # for picking the right bash on macOS
export GPG_TTY=$(tty)

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ $(uname -n) == "sierra" ]; then # we are on the home machine
  export GIT_REPO_DIR=/storage/git
fi

# include Borg Backup secrets
if [ -f "$HOME"/.borg_secrets  ]; then
  . "$HOME"/.borg_secrets
fi

backup () {
  $GIT_REPO_DIR/backup/backup.sh |& tee -a "$HOME"/.log/"borg-$(echo "$HOSTNAME")-$(date +"%Y-%m-%d").log"
  if [ "$1" = "shutdown" ]; then
    sudo shutdown
  fi
}
