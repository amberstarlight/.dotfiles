# shellcheck shell=bash

#
# linux.sh
#

alias open='xdg-open'
alias hx='helix --config ${DOTFILES_DIR}/config/helix/config.toml'

export VISUAL="helix --config $DOTFILES_DIR/config/helix/config.toml"

# set xdg base dirs on arch
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
