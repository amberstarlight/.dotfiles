# shellcheck shell=bash

#
# alias.sh
#

alias ls='ls --color=auto'
alias path='echo -e ${PATH//:/\\n}'

# git
alias gist='git st'
alias gy='git checkout $(git_default_branch) && git pull && git gone'
# gpm conflicts with general purpose mouse

# Terraform
if command -v terraform &> /dev/null; then
  alias tf='terraform'
elif command -v tofu &> /dev/null; then
  alias tf='tofu'
fi

alias tfi='tf init'
alias tff='tf fmt'
alias tfv='tf validate'
alias tfp='tf plan'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfo='tf output'

# Granted
alias assume='. assume'

# clipboard harmonisation
if [ "$(uname)" == "Linux" ]; then
  if command -v xclip &> /dev/null; then
    alias copy="xclip -sel clip"
    alias paste="xclip -sel clip -o"
  fi

  if command -v wl-copy &> /dev/null; then
    alias copy="wl-copy"
    alias paste="wl-paste"
  fi
fi

if [ "$(uname)" == "Darwin" ]; then
  alias copy="pbcopy"
  alias paste="pbpaste"
fi
