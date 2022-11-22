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

mkcdir () {
  mkdir -p -- "$1" && cd -P "$1" || return
}

git_all () {
  for repository in */.git; do # TODO: support arg here
    (
      echo "$repository";
      cd "$repository"/.. || return;

      CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
      DEFAULT_BRANCH=$(git rev-parse --abbrev-ref origin/HEAD | cut -c8-)

      # check if symbolic link to origin/HEAD exists
      git rev-parse --abbrev-ref origin/HEAD >/dev/null 2>&1;

      if [ $? -eq 128 ]; then
        # create the symbolic ref before we attempt to use it
        git remote set-head origin -a;
      fi

      # insert stashing

      if [ ! "$CURRENT_BRANCH" == "$DEFAULT_BRANCH"  ]; then
        git checkout "$DEFAULT_BRANCH";
      fi

      # git pull;

      # insert stash popping
    );
  done
}
