# shellcheck shell=bash

#
# functions.sh
#

optional_s () {
  if [ ! "$1" -eq 1 ]; then
    env echo -n "s";
  fi
}

dot_clean () {
  local dir=${1:-.};
  local deleted_count;

  deleted_count=$(find "$dir" -maxdepth 1 -type f \( \
    -iname "._*" -o                                  \
    -iname ".DS_Store" -o                            \
    -iname ".Spotlight-V100" -o                      \
    -iname ".Trashes" -o                             \
    -iname "Thumbs.db" -o                            \
    -iname ".apdisk"                                 \
  \) -delete -print | wc -l);

  env echo -n "Processed $deleted_count item$(optional_s "$deleted_count")."
}
