#!/bin/bash
# Parse BuildKit --progress=plain output and the Dockerfile to produce a per-step
# timing table. Each RUN instruction is mapped back to the comment that precedes it.
#
# Usage: parse-build-timings.sh <build-log> <dockerfile>
# Output: tab-separated lines of "label\tduration" written to stdout.

BUILD_LOG=$1
DOCKERFILE=$2

[ ! -f "$BUILD_LOG" ] || [ ! -f "$DOCKERFILE" ] && exit 0

# Build an ordered list of labels for each RUN instruction in the Dockerfile.
# Index 1 = first RUN, index 2 = second RUN, etc.
declare -A COMMENT_BY_INDEX
RUN_INDEX=0
PREV_COMMENT=
IN_RUN=false
while IFS= read -r line; do
  if $IN_RUN; then
    # Check if this continuation line ends with backslash
    if [[ $line =~ \\$ ]]; then
      continue
    fi
    IN_RUN=false
  elif [[ $line =~ ^#\  ]]; then
    PREV_COMMENT=$line
  elif [[ $line =~ ^RUN\  ]]; then
    RUN_INDEX=$((RUN_INDEX + 1))
    if [ -n "$PREV_COMMENT" ]; then
      # Strip leading "# " from comment
      COMMENT_BY_INDEX[$RUN_INDEX]=${PREV_COMMENT#\# }
    fi
    PREV_COMMENT=
    if [[ $line =~ \\$ ]]; then
      IN_RUN=true
      continue
    fi
  else
    [[ -z $line ]] || PREV_COMMENT=
  fi
done < "$DOCKERFILE"

# Parse BuildKit plain-progress output.
# Lines of interest:
#   #N [stage-0 M/T] RUN <command>...    (step start, captures step index M)
#   #N DONE Xs                           (step completion with duration)
#   #N CACHED                            (cached step, duration = 0)
declare -A STEP_INDEX  # Maps BuildKit step id to Dockerfile RUN index
declare -A STEP_CMD    # Maps BuildKit step id to truncated command
declare -A STEP_TIME

while IFS= read -r line; do
  # Match step command: "#12 [stage-0 5/42] RUN apt-get update ..."
  if [[ $line =~ ^'#'([0-9]+)[[:space:]]+\[stage-0[[:space:]]+([0-9]+)/[0-9]+\][[:space:]]+RUN[[:space:]]+(.*) ]]; then
    STEP_ID=${BASH_REMATCH[1]}
    STEP_INDEX[$STEP_ID]=${BASH_REMATCH[2]}
    STEP_CMD[$STEP_ID]=$(echo "${BASH_REMATCH[3]}" | cut -c1-60)
  fi
  # Match DONE: "#12 DONE 15.2s"
  if [[ $line =~ ^'#'([0-9]+)' DONE '([0-9.]+)'s' ]]; then
    STEP_ID=${BASH_REMATCH[1]}
    STEP_TIME[$STEP_ID]=${BASH_REMATCH[2]}
  fi
  # Match CACHED: "#12 CACHED"
  if [[ $line =~ ^'#'([0-9]+)' CACHED' ]]; then
    STEP_ID=${BASH_REMATCH[1]}
    STEP_TIME[$STEP_ID]=cached
  fi
done < "$BUILD_LOG"

# Emit rows sorted by step id (execution order)
for STEP_ID in $(echo "${!STEP_CMD[@]}" | tr ' ' '\n' | sort -n); do
  DURATION=${STEP_TIME[$STEP_ID]:-unknown}
  IDX=${STEP_INDEX[$STEP_ID]}
  LABEL=${COMMENT_BY_INDEX[$IDX]:-}
  # If no comment match, use a truncated version of the command itself
  if [ -z "$LABEL" ]; then
    LABEL=$(echo "${STEP_CMD[$STEP_ID]}" | cut -c1-60)
  fi
  echo -e "${LABEL}\t${DURATION}"
done
