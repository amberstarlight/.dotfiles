#
# export.sh
#

export COLUMNS
export GPG_TTY=$(tty)
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:??:[ ]*:clear:exit:logout"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add ../bin so we can use sync-dotfiles anywhere
export PATH="$PATH:$HOME/.dotfiles/bin"
