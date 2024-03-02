# shellcheck shell=bash

#
# functions.sh
#

dot_clean () {
  local dir=${1:-.};
  local deleted_count;

  deleted_count=$(find "$dir" -maxdepth 1 -type f \( \
    -iname "._*" -o                                  \
    -iname ".DS_Store" -o                            \
    -iname ".Spotlight-V100" -o                      \
    -iname ".Trash*" -o                              \
    -iname ".TemporaryItems" -o                      \
    -iname ".fseventsd" -o                           \
    -iname "Thumbs.db" -o                            \
    -iname ".apdisk"                                 \
  \) -delete -print | wc -l);

  env echo -n "Processed $deleted_count item$(optional_s "$deleted_count")."
}

git_current_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

git_default_branch() {
  git rev-parse --abbrev-ref origin/HEAD 2> /dev/null | cut -c8-
}

git_prune_branches() {
  git branch --merged | grep -v main >/tmp/merged-branches && \
  $EDITOR /tmp/merged-branches && \
  xargs git branch -d </tmp/merged-branches \
  && git fetch -pv
}

is_ssh() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
    return 0
  else
    return 1
  fi
}

mkcdir () {
  mkdir -p -- "$1" && cd -P "$1" || return
}

optional_s () {
  if [ ! "$1" -eq 1 ]; then
    env echo -n "s";
  fi
}

prune_git_branches() {
  git branch --merged | grep -v main >/tmp/merged-branches && \
  hx /tmp/merged-branches && \
  xargs git branch -d </tmp/merged-branches \
  && git fetch -pv
}

mktouch() {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

file_addition_year () {
  local file
  local date

  file=$1
  date=$(git log --diff-filter=A --follow --format=%as "$file")
  echo "${date:0:4}"
}
