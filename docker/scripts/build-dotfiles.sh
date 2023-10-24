REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Set the cachebust file to rebuild from dotfiles onwards
DOTFILES_CACHEBUST=$(date +%s > $REPO_ROOT/.dotfiles-cachebust)

# Rebuild the desktop environment
$REPO_ROOT/docker/scripts/build.sh

# Store build exit code
echo $? > $REPO_ROOT/.build-exit-code
