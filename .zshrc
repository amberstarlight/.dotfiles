autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

files=("alias" "export" "functions")

if [[ "$(uname)" == "Linux" ]]; then
  files+=("linux")
  if [[ "$(uname -n)" == "sierra" ]]; then
    files+=("sierra")
  fi
else
  files+=("darwin")
fi

# Things that must come last
files+=("finally")

for file in "${files[@]}"; do
  source "$HOME/.dotfiles/bash/$file.sh"
done
