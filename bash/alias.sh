#
# alias.sh
#

alias ls='ls --color=auto'
alias rm='rm -vI'
alias cp='cp -vi'
alias mv='mv -vi'
alias path='echo -e ${PATH//:/\\n}'

# Terraform
alias tf='terraform'
alias tfi='tf init'
alias tff='tf fmt'
alias tfv='tf validate'
alias tfp='tf plan'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfo='tf output'
