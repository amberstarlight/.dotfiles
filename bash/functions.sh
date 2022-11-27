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

        echo -e "${BLUE}Stashing existing changes...${NC}"
        stash_result=$(git stash push -m "Local changes before pulling $(git_default_branch)")
        needs_pop=1
        if [ "$stash_result" = "No local changes to save" ]; then
          needs_pop=0
        fi

        if [ ! "$(git_current_branch)" == "$(git_default_branch)" ]; then
          git checkout "$(git_default_branch)";
        fi

        echo -e "${BLUE}Pulling updates from $(git_default_branch)...${NC}\n"
        git pull origin "$(git_default_branch)"
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
          git checkout "$(git_current_branch)"
        fi

      else
        echo -e "${BLUE} ${repository} has no remote defined, skipping!${NC}\n"
      fi

    );
  done
}

git_current_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

git_default_branch() {
  git rev-parse --abbrev-ref origin/HEAD 2> /dev/null | cut -c8-
}

is_ssh() {
  if [[ $(who am i) =~ \([-a-zA-Z0-9\.]+\)$ ]]; then
    return 1
  else
    return 0
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
