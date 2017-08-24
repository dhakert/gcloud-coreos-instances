#!/bin/bash

gcloud compute --project="_PROJECT_" ssh --zone="_ZONE_" "core@pro-control" --ssh-flag="-A"
