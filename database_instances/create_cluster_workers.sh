#!/bin/bash
# Create Production cluster workers

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
# worker instance type
# worker_machine_type=f1-micro
worker_machine_type=n1-standard-1

instance_name=prod-node1

# get the latest full image name
image=$(gcloud compute images list --project=$project | grep -v grep | grep coreos-$channel | awk {'print $1'})
##

# create web1 instance
gcloud compute instances create $instance_name --project=$project --image=$image \
 --image-project=coreos-cloud --boot-disk-size=20 --zone=$zone \
 --machine-type=$worker_machine_type --metadata-from-file \
 user-data=cloud-config/node1.yaml --can-ip-forward --tags $instance_name,prod

# create a static IP for the new web1 instance
# gcloud compute routes create ip-10-220-2-1-$instance_name --project=$project \
#          --next-hop-instance $instance_name \
#                   --next-hop-instance-zone $zone \
#                            --destination-range 10.220.2.1/32

# create web2 instance
# gcloud compute instances create prod-web2 --project=$project --image=$image \
#  --image-project=coreos-cloud --boot-disk-size=20 --zone=$zone \
#  --machine-type=$worker_machine_type --metadata-from-file \
#  user-data=cloud-config/web2.yaml --can-ip-forward --tags=prod-web2,prod

# create a static IP for the new web2 instance
# gcloud compute routes create ip-10-220-3-1-prod-web2 --project=$project \
#          --next-hop-instance prod-web2 \
#                   --next-hop-instance-zone $zone \
#                            --destination-range 10.220.3.1/32

echo " "
echo "Setup has finished !!!"
pause 'Press [Enter] key to continue...'
