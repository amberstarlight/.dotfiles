# shellcheck shell=bash

#
# darwin.sh
#

export HOMEBREW_BUNDLE_FILE="$HOME/.dotfiles/.brewfile"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$PATH"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# override darwin system ruby, forcibly
if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=$(gem environment gemdir)/bin:$PATH
fi

# configure rbenv
if command -v rbenv > /dev/null; then
  eval "$(rbenv init - --no-rehash bash)"
fi

# force libpq to not use GSS encryption
export PGGSSENCMODE="disable"

# docker desktop wants this
export PATH="$PATH:${HOME}/.docker/bin"
