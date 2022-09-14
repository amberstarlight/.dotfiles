# shellcheck shell=bash

#
# functions.sh
#

dot_clean () {
  local dir=${1:-.};

  find "$dir" -type f \( 	\
    -iname "._*" -o		\
    -iname ".DS_Store" -o	\
    -iname ".Spotlight-V100" -o \
    -iname ".Trashes" -o	\
    -iname "Thumbs.db" -o	\
    -iname ".apdisk"		\
  \) -delete;
}
