#
# sierra.sh
#

if [ $(uname -n) == "sierra" ]; then # we are on the home machine
  export GIT_REPO_DIR=/storage/git

  # include Borg Backup secrets
  if [ -f "$HOME"/.borg_secrets  ]; then
    source "$HOME"/.borg_secrets
  fi

  backup () {
    $GIT_REPO_DIR/backup/backup.sh |& tee -a "$HOME"/.log/"borg-$(echo "$HOSTNAME")-$(date +"%Y-%m-%d").log"
    if [ "$1" = "shutdown" ]; then
      sudo shutdown
    fi
  }
fi
