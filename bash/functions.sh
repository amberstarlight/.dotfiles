# shellcheck shell=bash

#
# functions.sh
#

dot_clean () {
  local dir=${1:-.};
  local tmp_file=".tmp-$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 10 | head -n 1)";

  find "$dir" -maxdepth 1 -type f \(     \
    -iname "._*" -o                      \
    -iname ".DS_Store" -o                \
    -iname ".Spotlight-V100" -o          \
    -iname ".Trashes" -o                 \
    -iname "Thumbs.db" -o                \
    -iname ".apdisk"                     \
  \) -delete -fprintf "$tmp_file" "$dir";

  echo "Processed $(wc -c <"$tmp_file") items.";
  \rm "$tmp_file";
}
