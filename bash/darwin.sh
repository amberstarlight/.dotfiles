# shellcheck shell=bash

#
# darwin.sh
#

export EDITOR=/usr/local/bin/nano
export HOMEBREW_BUNDLE_FILE="$HOME/.dotfiles/Brewfile"
export NANO_RC_FILE="${HOME}/.dotfiles/.nanorc.darwin"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
