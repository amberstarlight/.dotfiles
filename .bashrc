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

# Things that must come last
files+=("finally")

for file in "${files[@]}"; do
  source "$HOME/.dotfiles/bash/$file.sh"
done

if command -v tmux &> /dev/null \
  && [ -n "$PS1" ]              \
  && [[ ! "$TERM" =~ screen ]]  \
  && [[ ! "$TERM" =~ tmux ]]    \
  && [ -z "$TMUX" ]; then
  read -p "Start tmux? [Y/n] " -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    tmux attach || tmux new -AD -t main -s main
  fi
fi
