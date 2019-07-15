REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# Rebuild the desktop environment from dotfiles onwards
DOTFILES_CACHEBUST=$(date) $REPO_ROOT/docker/scripts/build.sh
