#!/bin/bash
# Create Production cluster control

# Update required settings in "settings" file before running this script

function pause(){
read -p "$*"
}

## Fetch GC settings
# project and zone
project=api-project-7872450353
zone=asia-northeast1-c
# CoreOS release channel
channel=stable
# control instance type
# control_machine_type=g1-small
control_machine_type=n1-standard-1

# get the latest full image name
image=$(gcloud compute images list --project=$project | grep -v grep | grep coreos-$channel | awk {'print $1'})
##

# create an instance
gcloud compute instances create pro-database-control --project=$project --image=$image \
 --image-project=coreos-cloud --boot-disk-size=10 --zone=$zone \
 --machine-type=$control_machine_type --metadata-from-file \
 user-data=cloud-config/database-control.yaml \
 --can-ip-forward --tags=pro-database-control,prod

# create a static IP for the new instance
gcloud compute routes create ip-10-220-1-1-pro-database-control --project=$project \
         --next-hop-instance pro-database-control \
                  --next-hop-instance-zone $zone \
                           --destination-range 10.220.1.1/32

echo " "
echo "Setup has finished !!!"
pause 'Press [Enter] key to continue...'
