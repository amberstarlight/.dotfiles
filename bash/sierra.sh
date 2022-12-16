# shellcheck shell=bash

#
# sierra.sh
#

export GIT_REPO_DIR="$HOME/git"
export PATH="$PATH:$HOME/.local/bin"

# include Borg Backup secrets
if [ -f "$HOME"/.borg_secrets  ]; then
  source "$HOME"/.borg_secrets
fi

backup () {
  "$GIT_REPO_DIR/backup/backup.sh" |& tee -a "$HOME/.log/borg-sierra-$(date +"%Y-%m-%d").log"
}

skip-discord-update () {
  sed -i '2 i \ \ "SKIP_HOST_UPDATE": true,' "$HOME/.config/discord/settings.json"
}
