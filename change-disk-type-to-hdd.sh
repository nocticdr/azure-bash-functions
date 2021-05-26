#####################################
############# FUNCTIONS #############
#####################################
# Bash Colours
#https://gist.github.com/vratiu/9780109
#https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux?rq=1
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

BOLD='\e[1m'
UNDERLINE='\e[4m'
NU='\e[24m' # No Underline
DGREY='\033[1;30m'
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# This function will stop/deallocate a VM and change all it's disk from Standard_SSD or Premium_SSD to Standard_LRS
# Call this function as follows:
# disk_type_hdd <resource-group> <agw-name>

disk_type_hdd()
{
  rg=$1
  name=$2
  az vm deallocate -n $name -g $rg
  datadisk=`az vm show -n $name -g $rg --query 'storageProfile.dataDisks[].name' -o tsv`
  osdisk=`az vm show -n $name -g $rg --query 'storageProfile.osDisk.name' -o tsv`
  disks="$osdisk
  $datadisk"
  while read -r line; do
    az disk update -n $line -g $rg --sku "Standard_LRS"
  done <<< "$disks"
  az vm start -n $name -g $rg
}