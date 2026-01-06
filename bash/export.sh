# shellcheck shell=bash

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
export PATH="$PATH:$HOME/.local/bin"

export DOTFILES_DIR="$HOME/.dotfiles"

# configure editor; `hx` should open Helix
# sometimes the binary is hx, sometimes it's helix
# if we don't have it, fallback to vi and warn

if command -v hx >/dev/null 2>&1; then
  export VISUAL="hx"
elif command -v helix >/dev/null 2>&1; then
  alias hx="helix"
  export VISUAL="helix"
else
  alias hx='echo "WARN: helix not installed"'
  export VISUAL="vi"
fi

export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"
