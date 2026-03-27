# Show only desktop environment source repositories that are dirty or have unpushed commits
# Untracked files matching these patterns are considered build artifacts and suppressed
BUILD_ARTIFACTS='\.a$|\.build/$|\.cmake$|\.o$|\.pc$|\.qm$|\.qmake\.stash$|\.so(\.[0-9]+)*$|~$|CMakeCache\.txt$|CMakeFiles/$|Makefile$|config\.log$|config\.status$'
OPERATION=${1:-status}

for repo in $DESKTOP_ENVIRONMENT_SOURCE_HOME/*/; do
  test -d $repo/.git || continue

  name=$(basename $repo)
  dirty=$(git -C $repo status --short 2>/dev/null | grep --extended-regexp --invert-match "^\?\? .*($BUILD_ARTIFACTS)")
  unpushed=$(git -C $repo log @{u}..HEAD --oneline 2>/dev/null)

  test -n "$dirty" -o -n "$unpushed" || continue

  echo "$name:"
  if [ "$OPERATION" = diff ]; then
    git -C $repo diff
  else
    test -n "$dirty" && echo "$dirty"
  fi
  test -n "$unpushed" && echo "$unpushed" | sed 's/^/ (unpushed) /'
done
