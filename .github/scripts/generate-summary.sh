#!/bin/bash
# Generate a GitHub Actions job summary with host specs, step timings, and error output.
#
# Required env vars (set by workflow):
#   JOB_STATUS, TIME_WORKFLOW_START (or TIME_DEPLOY_START), GITHUB_STEP_SUMMARY
#
# Optional env vars (include the relevant steps in the summary if set):
#   STEP_BUILD_OUTCOME, STEP_PUSH_OUTCOME, STEP_TEST_OUTCOME, STEP_HEADLESS_OUTCOME,
#   TIME_BUILD_START, TIME_BUILD_END, TIME_PUSH_START, TIME_PUSH_END
#
# On build failure, fetches the last 50 lines of the Build step via the GitHub API:
#   GITHUB_TOKEN, GITHUB_REPOSITORY, GITHUB_RUN_ID, RUNNER_NAME (all automatic in GitHub Actions)

fmt() { printf '%dm %02ds' $(($1 / 60)) $(($1 % 60)); }

# Collect host specs
SPEC_OS=$(. /etc/os-release && echo "$PRETTY_NAME")
SPEC_KERNEL=$(uname -r)
SPEC_CPU=$(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | xargs)
SPEC_CPU_CORES=$(nproc)
SPEC_RAM=$(free | awk '/^Mem:/ {printf "%.1f GiB", $2/1024/1024}')
SPEC_DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}' | sed 's/\([0-9.]*\)\([KMGT]\)/\1 \2iB/g')
SPEC_GPU=$(nvidia-smi --query-gpu=name,memory.total --format=csv,noheader 2>/dev/null | head -1)

NOW=$(date +%s)
START=${TIME_WORKFLOW_START:-${TIME_DEPLOY_START:-$NOW}}
TOTAL_FMT=$(fmt $(( NOW - START )))

# Host specs
echo "# Workflow Summary" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY
echo "**Status:** $JOB_STATUS" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY
echo "## Host Specs" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY
echo "| Property | Value |" >> $GITHUB_STEP_SUMMARY
echo "|---|---|" >> $GITHUB_STEP_SUMMARY
echo "| OS | $SPEC_OS |" >> $GITHUB_STEP_SUMMARY
echo "| Kernel | $SPEC_KERNEL |" >> $GITHUB_STEP_SUMMARY
echo "| CPU | $SPEC_CPU ($SPEC_CPU_CORES cores) |" >> $GITHUB_STEP_SUMMARY
echo "| RAM | $SPEC_RAM |" >> $GITHUB_STEP_SUMMARY
echo "| Disk | $SPEC_DISK |" >> $GITHUB_STEP_SUMMARY
[ -n "$SPEC_GPU" ] && echo "| GPU | $SPEC_GPU |" >> $GITHUB_STEP_SUMMARY

# Step timings
echo "" >> $GITHUB_STEP_SUMMARY
echo "## Step Timings" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY
echo "| Step | Duration | Status |" >> $GITHUB_STEP_SUMMARY
echo "|---|---|---|" >> $GITHUB_STEP_SUMMARY
if [ -n "$TIME_BUILD_START" ] && [ -n "$TIME_BUILD_END" ]; then
  echo "| Build | $(fmt $(( TIME_BUILD_END - TIME_BUILD_START ))) | $STEP_BUILD_OUTCOME |" >> $GITHUB_STEP_SUMMARY
fi
if [ -n "$TIME_PUSH_START" ] && [ -n "$TIME_PUSH_END" ]; then
  echo "| Push | $(fmt $(( TIME_PUSH_END - TIME_PUSH_START ))) | $STEP_PUSH_OUTCOME |" >> $GITHUB_STEP_SUMMARY
fi
[ -n "$STEP_TEST_OUTCOME" ] && echo "| Tests | — | $STEP_TEST_OUTCOME |" >> $GITHUB_STEP_SUMMARY
[ -n "$STEP_HEADLESS_OUTCOME" ] && echo "| Headless desktop | — | $STEP_HEADLESS_OUTCOME |" >> $GITHUB_STEP_SUMMARY
echo "| **Total** | **$TOTAL_FMT** | **$JOB_STATUS** |" >> $GITHUB_STEP_SUMMARY

# Fetch build step logs via GitHub API on failure
[ "$STEP_BUILD_OUTCOME" != "failure" ] && exit 0

JOB_ID=$(curl -sf \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID/jobs" | \
  jq -r ".jobs[] | select(.runner_name == \"$RUNNER_NAME\") | .id" | head -1)

[ -z "$JOB_ID" ] && exit 0

BUILD_LOGS=$(curl -sL \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/jobs/$JOB_ID/logs" | \
  awk '/##\[group\]Build\r?$/{depth=1;next} depth==0{next} /##\[group\]/{depth++;next} /##\[endgroup\]/{if(--depth==0)exit;next} {sub(/^[0-9T:.Z]+ /,""); sub(/\r/,""); print}' | \
  tail -50)

[ -z "$BUILD_LOGS" ] && exit 0

echo "" >> $GITHUB_STEP_SUMMARY
echo "## Build Error" >> $GITHUB_STEP_SUMMARY
echo '```' >> $GITHUB_STEP_SUMMARY
printf '%s\n' "$BUILD_LOGS" >> $GITHUB_STEP_SUMMARY
echo '```' >> $GITHUB_STEP_SUMMARY
