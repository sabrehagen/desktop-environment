REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Export desktop environment shell configuration
eval "$($REPO_ROOT/docker/scripts/environment.sh)"

# create logfile name
FILE_NAME=build-logs-$(date +%s).txt

# do build and make timestamped logs
$REPO_ROOT/docker/scripts/build.sh | while read logline ; do echo "$(date +%s) | $logline"; done | tee -a $FILE_NAME


 | awk -F, '{a=$1;next} {print $1-a}' output.txt
cat $REPO_ROOT/$FILE_NAME | grep -E '\[.{3,5}\]' | awk -F, '{a=$1;next} {$1=$1-a; print $0}' output.txt


tac $REPO_ROOT/$FILE_NAME | grep -E '\[.{3,5}\]' | grep -v 'name:' | awk '{if(x){t=x-$1}{x=$1;$1=t;print $1, $6,$7,$8,$9,$10}}' | tac
