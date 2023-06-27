# shellcheck shell=bash

#
# darwin.sh
#

alias hx='hx --config $HELIX_CONFIG'

export VISUAL="hx --config $HELIX_CONFIG"

export HOMEBREW_BUNDLE_FILE="$HOME/.dotfiles/.brewfile"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$PATH"

# todo: make PATH up from an array/list
eval "$(rbenv init - bash)"
