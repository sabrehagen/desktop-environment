REPO_ROOT=$(dirname $(readlink -f $0))/../..

# Destroy the desktop environment cloud virtual machine
$REPO_ROOT/terraform/scripts/terraform.sh apply -auto-approve -input=false
