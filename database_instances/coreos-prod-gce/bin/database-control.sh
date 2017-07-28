#!/bin/bash

gcloud compute --project="api-project-7872450353" ssh --zone="asia-northeast1-c" "core@prod-control1" --ssh-flag="-A"
