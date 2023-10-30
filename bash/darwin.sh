# shellcheck shell=bash

#
# darwin.sh
#

alias hx='hx --config $HELIX_CONFIG'

export VISUAL="hx --config $HELIX_CONFIG"

export HOMEBREW_BUNDLE_FILE="$HOME/.dotfiles/.brewfile"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$PATH"

if which ruby >/dev/null && which gem >/dev/null; then
  export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# todo: make PATH up from an array/list
eval "$(rbenv init - bash)"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
