#!/bin/bash

# this is a temporary quick hack.. the directories didn't exist in the EFS so
# I had to mount the root of the EFS at a different path (/mnt/efs) then create each directory

mkdir /mnt/efs/acme
mkdir /mnt/efs/acme-data
mkdir /mnt/efs/certs
mkdir /mnt/efs/certs/${DOMAIN}
