# shellcheck shell=bash

#
# alias.sh
#

alias back='cd -'
alias cp='cp -vi'
alias ls='ls --color=auto'
alias mv='mv -vi'
alias nano='nano --rcfile ${NANO_RC_FILE}'
alias path='echo -e ${PATH//:/\\n}'
alias rm='rm -vI'

# git
alias gist='git st'

# Terraform
alias tf='terraform'
alias tfi='tf init'
alias tff='tf fmt'
alias tfv='tf validate'
alias tfp='tf plan'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfo='tf output'
