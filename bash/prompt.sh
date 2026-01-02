# shellcheck shell=bash
# shellcheck disable=SC2034

#
# prompt.sh
#

# Standard foreground colours
ST_BLK="\[$(tput setaf 0)\]"
ST_RED="\[$(tput setaf 1)\]"
ST_GRN="\[$(tput setaf 2)\]"
ST_YLW="\[$(tput setaf 3)\]"
ST_BLU="\[$(tput setaf 4)\]"
ST_PRP="\[$(tput setaf 5)\]"
ST_CYN="\[$(tput setaf 6)\]"
ST_GRY="\[$(tput setaf 7)\]"

# High-intensity foreground colours
HI_GRY="\[$(tput setaf 8)\]"
HI_RED="\[$(tput setaf 9)\]"
HI_GRN="\[$(tput setaf 10)\]"
HI_YLW="\[$(tput setaf 11)\]"
HI_BLU="\[$(tput setaf 12)\]"
HI_PRP="\[$(tput setaf 13)\]"
HI_CYN="\[$(tput setaf 14)\]"
HI_WHT="\[$(tput setaf 15)\]"

# tput capabilities
BLD="\[$(tput bold)\]"
DIM="\[$(tput dim)\]"
REV="\[$(tput rev)\]"
RST="\[$(tput sgr0)\]"

host() {
  local colour=${ST_GRN}
  local label="$"
  local text="\h"

  if was_error "$1"; then
    colour=${HI_RED}
    label="!"
  elif is_root; then
    colour=${ST_PRP}
    label="#"
  elif is_ssh; then
    colour=${ST_BLU}
  fi

  if is_ssh; then
    text="\u@\h"
  fi

  echo "${REV}${colour}${label} ${text} ${RST}"
}

was_error() {
  if [[ "$1" -ne 0 && "$1" -ne 130 ]]; then
    return 0;
  else
    return 1;
  fi
}

generatePrompt() {
  status=$?
  PROMPT_DIRTRIM=2
  PS1=""

  host="\n$(host "$status")"
  time="$(date +%T)"
  dir="${BLD}${ST_RED}\w${RST}"
  git="${ST_CYN}$(git_current_branch)${RST}"
  input="\n> ${RST}"

  PS1+="${host} ${time} ${dir} ${git}${input}"
}

PROMPT_COMMAND=generatePrompt
