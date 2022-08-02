#
# darwin.sh
#

alias nano='nano --rcfile $HOME/.dotfiles/.nanorc.darwin'

export EDITOR=/usr/local/bin/nano
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
export HOMEBREW_BUNDLE_FILE="$HOME/.dotfiles/Brewfile"
