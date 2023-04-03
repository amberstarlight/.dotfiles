# shellcheck shell=bash
# shellcheck disable=SC2034

#
# prompt.sh
#

# Standard colours
ST_BLK="\[$(tput setaf 0)\]"
ST_RED="\[$(tput setaf 1)\]"
ST_GRN="\[$(tput setaf 2)\]"
ST_YLW="\[$(tput setaf 3)\]"
ST_BLU="\[$(tput setaf 4)\]"
ST_PRP="\[$(tput setaf 5)\]"
ST_CYN="\[$(tput setaf 6)\]"
ST_GRY="\[$(tput setaf 7)\]"

# High-intensity colours
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
RST="\[$(tput sgr0)\]"

hostColour() {
  if is_ssh; then
    echo "${HI_BLU}"
  else
    echo "${ST_GRN}"
  fi
}

exitStatus() {
  if [[ "$1" -ne 0 ]]; then
    echo "${HI_RED}"
  else
    echo "${ST_GRN}"
  fi
}

generatePrompt() {
  local exit_status="$?"
  local workdir="\w"
  local current_user="\u"
  local hostname="\h"

  # do this first so we don't override $?
  promptEnd="\n$(exitStatus exit_status)> ${RST}"

  promptTime="${HI_GRY}$(date +%c)${RST}"
  promptHost="${ST_GRN}${current_user}${RST}${HI_GRY}@${RST}$(hostColour)${hostname}${RST}"
  promptDir="${BLD}${ST_RED}${workdir}${RST}"
  promptGit="${ST_CYN}$(git_current_branch)${RST}"

  PS1="\n${promptTime}\n${promptHost} ${promptDir} ${promptGit} ${promptEnd}"
}

PROMPT_COMMAND=generatePrompt
