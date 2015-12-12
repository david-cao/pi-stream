#!/bin/bash

# Modified from http://lg.io/2015/07/05/revised-and-much-faster-run-your-own-highend-cloud-gaming-service-on-ec2.html

set -e

# Set your AWS credentials here
# If you've already got an AWS credentials file, there's no need to set these
export AWS_ACCESS_KEY_ID=xxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxx

# Set this to the region closes to you. You can check this
# by going to http://www.cloudping.info/ and checking which
# region has the lowest ping.
export AWS_DEFAULT_REGION=us-east-1

# find an instance if the user has one up
echo -n "Finding a g2.2xlarge instance..."
INSTANCES=$( aws ec2 describe-instances --filters Name=instance-state-code,Values=16 Name=instance-type,Values=g2.2xlarge )
if [ $( echo "$INSTANCES" | jq '.Reservations | length' ) -ne "1" ]; then
	echo "You've got more than one g2.2xlarge instance!"
	exit
fi
INSTANCE_ID=$( echo "$INSTANCES" | jq --raw-output '.Reservations[0].Instances[0].InstanceId' )
echo "$INSTANCE_ID"

# Terminate the instance
echo "Terminating gaming instance..."
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID" > /dev/null

echo "All done!"
