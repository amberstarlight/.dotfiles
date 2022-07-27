#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Options
shopt -s checkwinsize # incase we are running on an older machine
shopt -s histappend

files=("alias" "export" "prompt")

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
