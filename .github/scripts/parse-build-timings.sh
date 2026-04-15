#!/bin/bash
# Parse BuildKit --progress=plain output and the Dockerfile to produce a per-step
# timing table. Each RUN instruction is mapped back to the comment that precedes it.
#
# Usage: parse-build-timings.sh <build-log> <dockerfile>
# Output: tab-separated lines of "label\tduration" written to stdout.

BUILD_LOG=$1
DOCKERFILE=$2

[ ! -f "$BUILD_LOG" ] || [ ! -f "$DOCKERFILE" ] && exit 0

# Build a map from a normalised prefix of each RUN command to its preceding comment.
# BuildKit collapses multi-line RUN commands into a single line, so we must do the same
# when building the key from the Dockerfile.
declare -A COMMENT_MAP
PREV_COMMENT=
IN_RUN=false
RUN_CMD=
while IFS= read -r line; do
  if $IN_RUN; then
    # Continuation line: strip leading whitespace, append
    STRIPPED=$(echo "$line" | sed 's/^[[:space:]]*//')
    RUN_CMD="$RUN_CMD $STRIPPED"
    # Check if this line continues (ends with \)
    if [[ $line =~ \\$ ]]; then
      # Remove trailing backslash
      RUN_CMD=${RUN_CMD% \\}
      continue
    fi
    IN_RUN=false
    # Normalise: collapse whitespace, take first 60 chars as key
    KEY=$(echo "$RUN_CMD" | tr -s ' ' | cut -c1-60)
    COMMENT_MAP[$KEY]=${PREV_COMMENT:-$KEY}
    PREV_COMMENT=
    RUN_CMD=
  elif [[ $line =~ ^#\  ]]; then
    PREV_COMMENT=$line
  elif [[ $line =~ ^RUN\  ]]; then
    RUN_CMD=${line#RUN }
    if [[ $line =~ \\$ ]]; then
      # Multi-line RUN: remove trailing backslash, continue collecting
      RUN_CMD=${RUN_CMD% \\}
      IN_RUN=true
      continue
    fi
    # Single-line RUN
    KEY=$(echo "$RUN_CMD" | tr -s ' ' | cut -c1-60)
    COMMENT_MAP[$KEY]=${PREV_COMMENT:-$KEY}
    PREV_COMMENT=
    RUN_CMD=
  else
    [[ -z $line ]] || PREV_COMMENT=
  fi
done < "$DOCKERFILE"

# Parse BuildKit plain-progress output.
# Lines of interest:
#   #N [stage-0 M/T] RUN <command>...    (step start, captures step id and command)
#   #N DONE Xs                           (step completion with duration)
#   #N CACHED                            (cached step, duration = 0)
declare -A STEP_CMD
declare -A STEP_TIME

while IFS= read -r line; do
  # Match step command: "#12 [stage-0 5/42] RUN apt-get update ..."
  if [[ $line =~ ^'#'([0-9]+)' '[^\]]*'] RUN '(.*) ]]; then
    STEP_ID=${BASH_REMATCH[1]}
    CMD=$(echo "${BASH_REMATCH[2]}" | tr -s ' ' | cut -c1-60)
    STEP_CMD[$STEP_ID]=$CMD
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
  CMD=${STEP_CMD[$STEP_ID]}
  DURATION=${STEP_TIME[$STEP_ID]:-unknown}
  LABEL=${COMMENT_MAP[$CMD]:-}
  # If no comment match, use a truncated version of the command itself
  if [ -z "$LABEL" ]; then
    LABEL=$(echo "$CMD" | cut -c1-60)
  else
    # Strip leading "# " from comment labels
    LABEL=${LABEL#\# }
  fi
  echo -e "${LABEL}\t${DURATION}"
done
