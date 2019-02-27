REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Check for changes to vcsh repositories before removing home volume
$REPO_ROOT/docker/scripts/exec.sh "vcsh status | grep -qE \"^ M \" -"
DOTFILES_CHANGED=$?

if [ "$DOTFILES_CHANGED" = "0" ]; then
  echo "Resolve uncommitted dotfiles changes before recycle!"
  exit 1
fi
