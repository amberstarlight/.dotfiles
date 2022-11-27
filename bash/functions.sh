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
    -iname ".Trash*" -o                              \
    -iname ".TemporaryItems" -o                      \
    -iname ".fseventsd" -o                           \
    -iname "Thumbs.db" -o                            \
    -iname ".apdisk"                                 \
  \) -delete -print | wc -l);

  env echo -n "Processed $deleted_count item$(optional_s "$deleted_count")."
}

mkcdir () {
  mkdir -p -- "$1" && cd -P "$1" || return
}

git_all () {

  BLUE='\033[1;34m'
  RED='\033[1;30m'
  NC='\033[0m'


  for git_dir in */.git; do
    (
      repository=${git_dir%/*}

      cd "$repository" || return;

      # check if there's actually a remote
      if git config --get remote.origin.url >/dev/null
      then

        # the first thing we should do is fetch from the remote
        git fetch origin --prune --progress

        # check if symbolic link to origin/HEAD exists
        if ! git rev-parse --abbrev-ref origin/HEAD >/dev/null
        then
          # create the symbolic ref before we attempt to use it
          git remote set-head origin -a;
        fi

        CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
        DEFAULT_BRANCH=$(git rev-parse --abbrev-ref origin/HEAD | cut -c8-)

        echo -e "${BLUE}Stashing existing changes...${NC}"
        stash_result=$(git stash push -m "Local changes before pulling \"${DEFAULT_BRANCH}\"")
        needs_pop=1
        if [ "$stash_result" = "No local changes to save" ]; then
          needs_pop=0
        fi

        if [ ! "$CURRENT_BRANCH" == "$DEFAULT_BRANCH" ]; then
          git checkout "$DEFAULT_BRANCH";
        fi

        echo -e "${BLUE}Pulling updates from \"${DEFAULT_BRANCH}\"...${NC}\n"
        git pull origin "${DEFAULT_BRANCH}"
        echo

        if [[ $needs_pop -eq 1 ]]; then
          echo -e "${BLUE}Popping stashed changes...${NC}\n"
          git stash pop
        fi

        unmerged_files=$(git diff --name-only --diff-filter=U)
        if [[ -n $unmerged_files ]]; then
          echo -e "${RED}The following files have merge conflicts after popping the stash:${NC}\n"
          printf %"s\n" "$unmerged_files"  # Ensure newlines are printed
          exit
        else
          git checkout "${CURRENT_BRANCH}"
        fi

      else
        echo -e "${BLUE} ${repository} has no remote defined, skipping!${NC}\n"
      fi

    );
  done
}
