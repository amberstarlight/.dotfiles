# shellcheck shell=bash

#
# alias.sh
#

alias ls='ls --color=auto'
alias path='echo -e ${PATH//:/\\n}'

# git
alias gist='git st'
alias gy='git checkout $(git_default_branch) && git pull'
# gpm conflicts with general purpose mouse

# Terraform
alias tf='terraform'
alias tfi='tf init'
alias tff='tf fmt'
alias tfv='tf validate'
alias tfp='tf plan'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfo='tf output'

# Granted
alias assume='. assume'
