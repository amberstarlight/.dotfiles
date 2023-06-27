# shellcheck shell=bash

#
# linux.sh
#

alias open='xdg-open'
alias hx='helix --config ${DOTFILES_DIR}/config/helix/config.toml'

export VISUAL="helix --config $DOTFILES_DIR/config/helix/config.toml"
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"
