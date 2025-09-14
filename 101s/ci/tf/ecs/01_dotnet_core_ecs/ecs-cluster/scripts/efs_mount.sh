#!/usr/bin/env bash

PATH=$PATH:/usr/local/bin

#Install jq, a JSON parser
yum -y install jq

#Install NFS client
if ! rpm -qa | grep -qw nfs-utils; then
    yum -y install nfs-utils
fi

if ! rpm -qa | grep -qw python27; then
	yum -y install python27
fi

#Install pip
yum -y install python27-pip

#Install awscli
pip install awscli

#Upgrade to the latest version of the awscli
pip install --upgrade awscli

#Add support for EFS to the CLI configuration
aws configure set preview.efs true

#Get region of EC2 from instance metadata
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$$:\\1:'`"


#Get EFS FileSystemID attribute
#Instance needs to be added to a EC2 role that give the instance at least read access to EFS
EFS_FILE_SYSTEM_ID="${filesystem_id}"

#Instance needs to be a member of security group that allows 2049 inbound/outbound
#The security group that the instance belongs to has to be added to EFS file system configuration
#Create variables for source and target
NFS_TARGET=$$EC2_AVAIL_ZONE.$$EFS_FILE_SYSTEM_ID.efs.$$EC2_REGION.amazonaws.com
MOUNTPOINT=/efs

#Create mount point
mkdir -p $$MOUNTPOINT

#Mount EFS file system
mount -t nfs4 $$NFS_TARGET:/ $$MOUNTPOINT

#Backup fstab
cp -p /etc/fstab /etc/fstab.back-$$(date +%F)

#Append line to fstab
echo -e "$$NFS_TARGET:/ \t\t $$MOUNTPOINT \t\t nfs \t\t defaults \t\t 0 \t\t 0" | tee -a /etc/fstab
