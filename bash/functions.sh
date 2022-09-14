# shellcheck shell=bash

#
# functions.sh
#

dot_clean () {
  dir=".";

  if [ -n "$1" ]; then
    dir="$1";
  fi

  find "$dir" -type f \( 	\
    -iname "._*" -o		\
    -iname ".DS_Store" -o	\
    -iname ".Spotlight-V100" -o \
    -iname ".Trashes" -o	\
    -iname "Thumbs.db" -o	\
    -iname ".apdisk"		\
  \) -delete;
}
