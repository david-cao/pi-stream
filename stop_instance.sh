#!/bin/bash

set -e

export AWS_ACCESS_KEY_ID=xxxxxxxx
export AWS_SECRET_ACCESS_KEY=yyyyyyy
export AWS_DEFAULT_REGION=us-west-1

# find an instance if the user has one up
echo -n "Finding a g2.2xlarge instance..."
INSTANCES=$( aws ec2 describe-instances --filters Name=instance-state-code,Values=16 Name=instance-type,Values=g2.2xlarge )
if [ $( echo "$INSTANCES" | jq '.Reservations | length' ) -ne "1" ]; then
	echo "You're already running a g2.2xlarge instance!"
	exit
fi
INSTANCE_ID=$( echo "$INSTANCES" | jq --raw-output '.Reservations[0].Instances[0].InstanceId' )
echo "$INSTANCE_ID"

export AMI_ID="ami-b31f52d9"

# Create an AMI from the existing instance (so we can restore it next time)
echo -n "Booting up an instance..."
AMI_ID=$( aws ec2 create-image --instance-id "$INSTANCE_ID" --name "ec2-gaming" | jq --raw-output '.ImageId' )
echo "$AMI_ID"

echo "Waiting for AMI to be created before terminating instance..."
if ! aws ec2 wait image-available --image-id "$AMI_ID"; then 
	echo "AMI never finished being created! Instance not terminated!";
	exit
fi

# Now that an image has been created terminate the instance
echo "Terminating gaming instance..."
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID" > /dev/null

echo "All done!"