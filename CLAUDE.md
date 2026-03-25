# Shell scripting conventions

- Always use `jq` for JSON parsing in shell scripts. Never use `python3` or `python` for JSON parsing.

---

# Testing changes before finishing

Before telling the user a task is complete, always verify the change is correct by testing it. For Dockerfile changes:

1. Add `RUN exit 123` immediately after the `RUN` step being added or modified.
2. Run `docker/scripts/build.sh`.
3. Confirm the build exits with code 123 — this proves the preceding step succeeded and Docker reached the sentinel.
4. Remove the `RUN exit 123` line.

Do not report a fix as complete until you have evidence the fix works.

---

# Adding a New Program to the Desktop Environment

This document describes the exact steps required to add a new program that is built from source to the desktop environment. Follow every step in order. All additions must be inserted in alphabetical order within their respective file.

The example program used throughout is `myprog`, installed from source to `$DESKTOP_ENVIRONMENT_SOURCE_HOME/myprog`. Substitute the real program name and repository URL as appropriate.

---

## Naming conventions

- The environment variable name is derived from the program's directory name under `$DESKTOP_ENVIRONMENT_SOURCE_HOME`, uppercased, with hyphens replaced by underscores.
- Example: directory `myprog` → variable `DESKTOP_ENVIRONMENT_SOURCE_MYPROG`
- Example: directory `my-prog` → variable `DESKTOP_ENVIRONMENT_SOURCE_MY_PROG`

---

## Step 1 — `docker/scripts/environment.sh`

Add one line to the "Desktop environment application source volumes" block, in alphabetical order among the other `DESKTOP_ENVIRONMENT_SOURCE_*` lines:

```sh
echo export DESKTOP_ENVIRONMENT_SOURCE_MYPROG=$DESKTOP_ENVIRONMENT_SOURCE_HOME/myprog
```

The block already begins with `DESKTOP_ENVIRONMENT_SOURCE_HOME` and is followed by the per-application lines. Do not change the `DESKTOP_ENVIRONMENT_SOURCE_HOME` line. The new line must follow the exact form of the surrounding lines — no quotes, no spaces around `=`.

---

## Step 2 — `docker/scripts/build.sh`

Add one `--build-arg` line inside the `docker build` invocation, in alphabetical order among the other `DESKTOP_ENVIRONMENT_SOURCE_*` build-arg lines:

```sh
  --build-arg DESKTOP_ENVIRONMENT_SOURCE_MYPROG=$DESKTOP_ENVIRONMENT_SOURCE_MYPROG \
```

The line uses two leading spaces, the `--build-arg` flag, `VAR=value` with no quotes, and a trailing ` \`. Place it alphabetically among the existing source build-arg lines, before `--file`.

---

## Step 3 — `docker/Dockerfile`

Two additions are required at the head of the Dockerfile, both in alphabetical order among the existing `DESKTOP_ENVIRONMENT_SOURCE_*` entries.

**3a.** Add one `ARG` line in the `ARG` block (before `ARG DESKTOP_ENVIRONMENT_USER`):

```dockerfile
ARG DESKTOP_ENVIRONMENT_SOURCE_MYPROG
```

**3b.** Add one `ENV` line in the `ENV` block immediately following the `ARG` block:

```dockerfile
ENV DESKTOP_ENVIRONMENT_SOURCE_MYPROG=$DESKTOP_ENVIRONMENT_SOURCE_MYPROG
```

The `ARG` lines have no default value and no `=`. The `ENV` lines assign the build arg of the same name to the environment variable of the same name. Both blocks are sorted alphabetically.

---

## Step 4 — `.github/workflows/build.yml` and `.github/workflows/build-from-dotfiles.yml`

No changes are required in the workflow files. Both workflows contain an "Export build args" step that runs `docker/scripts/environment.sh` dynamically with `DESKTOP_ENVIRONMENT_USER` and `DESKTOP_ENVIRONMENT_GITHUB_USER` set, passing all variables it produces to the Docker build automatically. Adding the variable to `environment.sh` in Step 1 is sufficient for it to be picked up here.

---

## Step 5 — `docker/scripts/start.sh`

Add one `--volume` line inside the `docker run` invocation, in alphabetical order among the other `DESKTOP_ENVIRONMENT_SOURCE_*` volume lines:

```sh
  --volume DESKTOP_ENVIRONMENT_SOURCE_MYPROG:$DESKTOP_ENVIRONMENT_SOURCE_MYPROG \
```

The left side of `:` is the Docker named volume (the bare variable name). The right side is the container-internal mount path (the expanded variable). Two leading spaces, trailing ` \`.

---

## Step 6 — `docker/Dockerfile` install block

Add a `RUN` block for the program in alphabetical order among the other install blocks. Use `$DESKTOP_ENVIRONMENT_SOURCE_MYPROG` wherever the source directory is referenced — never hardcode the path. Follow the style of surrounding blocks exactly: one `RUN` instruction per logical install unit, steps joined with ` && \`, two-space indentation.

Example:

```dockerfile
# Install myprog
RUN git clone --depth 1 --single-branch https://github.com/example/myprog $DESKTOP_ENVIRONMENT_SOURCE_MYPROG && \
  cd $DESKTOP_ENVIRONMENT_SOURCE_MYPROG && \
  make && \
  make install
```

---

## Step 7 — `~/.config/scripts/startup.sh` (daemon/startup services only)

If the program needs to run as a background daemon or startup service inside the container, add a tmux session block in alphabetical order among the other startup entries. Use `$DESKTOP_ENVIRONMENT_SOURCE_MYPROG` for any path references to the program's source directory.

```sh
# Start myprog
tmux new-session \
  -d \
  -s myprog \
  $DESKTOP_ENVIRONMENT_SOURCE_MYPROG/myprog \
  2>/dev/null
```

Rules:
- The comment `# Start <name>` immediately precedes the `tmux new-session` call with no blank line between them.
- `-d` and `-s <session-name>` are on their own lines, indented two spaces.
- The command and its arguments each go on their own line, indented two spaces.
- `2>/dev/null` is always the last line of the block.
- A blank line separates each block.
- If the service should only run when secrets are present, wrap it in `if [ $SECRETS_EXIST -eq 0 ]; then ... fi` as shown in the existing `screenpipe-ui` block.
- Skip this step entirely if the program is not a daemon or startup service.

---

## Step 8 — Persist application state (all stateful applications)

Applications write state (configuration, databases, caches that must survive container restarts) to paths under the user's home directory. That path must be mounted as a named Docker volume so it persists across container restarts.

### 8a — Determine the state directory

Run the application inside a temporary isolated container built from the desktop environment image and trace which paths under `$HOME` it creates or writes to on first launch. The recommended technique is `strace`:

```sh
strace -f -e trace=openat,mkdir -o /tmp/myprog-trace.txt myprog
grep -E 'O_WRONLY|O_RDWR|O_CREAT|mkdir' /tmp/myprog-trace.txt \
  | grep "$HOME"
```

Inspect the output to identify the top-level directories under `$HOME` where the application writes. Look separately for:

- **State** — persistent configuration and data the application must retain across restarts. Common locations:

  | Pattern | Example |
  |---|---|
  | `$HOME/.config/<appname>` | `$HOME/.config/transmission` |
  | `$HOME/.local/share/<appname>` | `$HOME/.local/share/TelegramDesktop` |
  | `$HOME/.<appname>` | `$HOME/.thunderbird` |

- **Cache** — regenerable data written under `$HOME/.cache/<appname>`. Only relevant if the application actually writes there.

Choose the most specific single directory for each that captures all writes without over-mounting large unrelated trees. If the application follows XDG conventions, prefer `$HOME/.config/<appname>` for state and `$HOME/.cache/<appname>` for cache.

### 8b — `docker/scripts/environment.sh` (state)

Add one line to the "Desktop environment application state volumes" block, in alphabetical order among the other `DESKTOP_ENVIRONMENT_STATE_*` lines. Use `$DESKTOP_ENVIRONMENT_USER_HOME` as the base — never hardcode `/home/<user>`:

```sh
echo export DESKTOP_ENVIRONMENT_STATE_MYPROG=$DESKTOP_ENVIRONMENT_USER_HOME/.config/myprog
```

The new line must follow the exact form of the surrounding lines — no quotes, no spaces around `=`.

### 8c — `docker/scripts/environment.sh` (cache — only if the application writes to `$HOME/.cache`)

If the strace output shows writes under `$HOME/.cache`, also add one line to the "Desktop environment application cache volumes" block, in alphabetical order among the other `DESKTOP_ENVIRONMENT_CACHE_*` lines:

```sh
echo export DESKTOP_ENVIRONMENT_CACHE_MYPROG=$DESKTOP_ENVIRONMENT_USER_HOME/.cache/myprog
```

Skip this step entirely if the application does not write to `$HOME/.cache`.

### 8d — `docker/scripts/start.sh` (state)

Add one `--volume` line inside the `docker run` invocation, in alphabetical order among the other `DESKTOP_ENVIRONMENT_STATE_*` volume lines, after all `DESKTOP_ENVIRONMENT_SOURCE_*` volumes:

```sh
  --volume DESKTOP_ENVIRONMENT_STATE_MYPROG:$DESKTOP_ENVIRONMENT_STATE_MYPROG \
```

The left side of `:` is the Docker named volume (the bare variable name). The right side is the container-internal mount path (the expanded variable). Two leading spaces, trailing ` \`.

### 8e — `docker/scripts/start.sh` (cache — only if step 8c was performed)

If a cache variable was added in step 8c, also add one `--volume` line in alphabetical order among the other `DESKTOP_ENVIRONMENT_CACHE_*` volume lines:

```sh
  --volume DESKTOP_ENVIRONMENT_CACHE_MYPROG:$DESKTOP_ENVIRONMENT_CACHE_MYPROG \
```

Skip this step entirely if step 8c was skipped.

---

## vcsh dotfiles repos — gitconfig filter rules

When adding a `diff`/`filter` driver to `~/.gitconfig` for a vcsh repo, always also track the repo's attributes file inside that same vcsh repo. The attributes file lives at:

```
~/.config/vcsh/repo.d/<repo-name>.git/info/attributes
```

**Always use `**/` prefix on patterns** in the attributes file. Exact paths like `.config/i3/config` will not be matched by git — patterns must use `**/` to resolve correctly (e.g. `**/.config/i3/config`). Verify with `vcsh <repo> check-attr filter diff -- <path>` — if it returns `unspecified`, the pattern is wrong.

After the filter and attributes file are in place, you must re-stage the tracked files once. This both writes the normalized content to the index and refreshes git's stat cache so subsequent status checks see the file as clean:

```sh
vcsh <repo-name> add <file>
vcsh <repo-name> commit -m "apply <filter-name> clean filter to <file>"
vcsh <repo-name> push
```

After creating the attributes file, add and commit it:

```sh
vcsh <repo-name> add ~/.config/vcsh/repo.d/<repo-name>.git/info/attributes
vcsh <repo-name> commit -m "track attributes file"
vcsh <repo-name> push
```

See `dotfiles-cursor` and `dotfiles-i3` for examples.

### How it works

**`filter.clean`** — runs when a file is staged. The sed command normalizes the volatile values before git stores the content in the index. So `gaps inner 20` becomes `gaps inner 0` in the index, regardless of what the working tree has.

**`filter.smudge`** — runs when a file is checked out. `cat` means pass-through — nothing is substituted back, so the file lands on disk exactly as stored in the repo (with the normalized values).

**`diff.textconv`** — runs when producing diff output. Applies the same normalization so that `git diff` and `git show` never surface these values as changes either.

The attributes file wires the named drivers to specific files. Each line is a glob pattern followed by an attribute assignment. Git reads this file from `info/attributes` (repo-local, not subject to normal `.gitattributes` worktree lookup) and applies the matching diff/filter driver whenever it operates on those paths.

**Why it silences `git status`** — status considers a file modified if `clean(worktree content) != index content`. Once you stage the file with the clean filter active, the index holds the normalized version. On every subsequent status check, git applies the clean filter to the working tree content and compares — both sides normalize to the same value, so the file disappears from status. After setting up the filter and attributes file, you must stage and commit the tracked files once to write the normalized content into the index:

```sh
vcsh <repo-name> add <file>
vcsh <repo-name> commit -m "apply <filter-name> clean filter to <file>"
vcsh <repo-name> push
```
