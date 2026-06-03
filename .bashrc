# shellcheck shell=bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Options
shopt -s checkwinsize # incase we are running on an older machine
shopt -s histappend

files=("alias" "export" "functions" "prompt")

if [ "$(uname)" == "Linux" ]; then
  files+=("linux")
  if [ "$(uname -n)" == "sierra" ]; then
    files+=("sierra")
  fi
else
  files+=("darwin")
fi

for file in "${files[@]}"; do
  source "$HOME/.dotfiles/bash/$file.sh"
done

# if nvm is installed on the system, set it up
if [ -d "${HOME}/.nvm" ]; then
  export NVM_DIR="${HOME}/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

if command -v tmux &> /dev/null \
  && [ -n "$PS1" ]              \
  && [[ ! "$TERM" =~ screen ]]  \
  && [[ ! "$TERM" =~ tmux ]]    \
  && [ -z "$TMUX" ]; then
  read -p "Start tmux? [Y/n] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    tmux attach || tmux new -AD -t main -s main
  fi
fi
