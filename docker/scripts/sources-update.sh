# Update all desktop environment source repositories
for repo in $DESKTOP_ENVIRONMENT_SOURCE_HOME/*/; do
  { test -d $repo/.git && git -C $repo pull --ff-only 2>&1 || true; } &
done
wait
