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

# bash special characters
HOST="\h"
USER="\u"
WDIR="\w"
DATE="\D{%Y-%m-%d}"
TIME="\A"

hostColour() {
  if is_ssh; then
    echo -e "${HI_BLU}"
  else
    echo -e "${ST_GRN}"
  fi
}

promptTime="${HI_GRY}${DATE} ${TIME}${RST}"
promptHost="${ST_GRN}${USER}${RST}${HI_GRY}@${RST}$(hostColour)${HOST}${RST}"
promptDir="${BLD}${HI_RED}${WDIR}${RST}"
promptGit="${HI_CYN}\$(git_current_branch)${RST}"
promptEnd="\n${HI_GRY}\$ ${RST}"

PS1="\n${promptTime}\n${promptHost} ${promptDir} ${promptGit}${promptEnd}"
