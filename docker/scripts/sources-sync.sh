# Sync all desktop environment source repositories with their upstreams
for repo in $DESKTOP_ENVIRONMENT_SOURCE_HOME/*/; do
  test -d $repo/.git || continue

  # Add upstream remote if not present
  if ! git -C $repo remote get-url upstream >/dev/null 2>&1; then
    origin=$(git -C $repo remote get-url origin)
    repo_path=$(echo $origin | sed 's|.*github.com[:/]||;s|\.git$||')
    parent=$(curl -sf https://api.github.com/repos/$repo_path | jq -r 'if .fork then .parent.clone_url else "" end' 2>/dev/null)
    test -n "$parent" && git -C $repo remote add upstream $parent
  fi

  # Sync with upstream if remote exists
  git -C $repo remote get-url upstream >/dev/null 2>&1 || continue
  git -C $repo fetch upstream && \
    git -C $repo rebase upstream/$(git -C $repo rev-parse --abbrev-ref HEAD) 2>&1 || true
done
