#!/bin/bash

set -e

# Set your AWS credentials here
# If you've already got an AWS credentials file, there's no need to set these
export AWS_ACCESS_KEY_ID=xxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxx

# Set this to the region closes to you. You can check this
# by going to http://www.cloudping.info/ and checking which
# region has the lowest ping.
export AWS_DEFAULT_REGION=us-east-1

# This is the AMI we created, it's public so this shouldn't be a problem
export AMI_ID=ami-b31f52d9

# Get the current lowest price for the GPU machine we want (we'll be bidding a cent above)
echo -n "Getting lowest g2.2xlarge bid..."
PRICE=$( aws ec2 describe-spot-price-history --instance-types g2.2xlarge --product-descriptions "Windows" --start-time `date +%s` | jq --raw-output '.SpotPriceHistory[].SpotPrice' | sort | head -1 )
echo $PRICE

# Create a spot instance requst, bid a cent higher than the max price.
echo -n "Creating spot instance request... "
SPOT_INSTANCE_ID=$( aws ec2 request-spot-instances --spot-price $( bc <<< "$PRICE + 0.01" ) --launch-specification file://specs.json| jq --raw-output '.SpotInstanceRequests[0].SpotInstanceRequestId' )
echo $SPOT_INSTANCE_ID

echo -n "Waiting for instance to be launched... "
aws ec2 wait spot-instance-request-fulfilled --spot-instance-request-ids "$SPOT_INSTANCE_ID"

INSTANCE_ID=$( aws ec2 describe-spot-instance-requests --spot-instance-request-ids "$SPOT_INSTANCE_ID" | jq --raw-output '.SpotInstanceRequests[0].InstanceId' )
echo "$INSTANCE_ID"

echo -n "Getting ip address... "
export IP=$( aws ec2 describe-instances --instance-ids "$INSTANCE_ID" | jq --raw-output '.Reservations[0].Instances[0].PublicIpAddress' )
echo "$IP"

echo "Waiting for server to become available..."
while ! ping -c1 $IP &>/dev/null; do sleep 5; done

echo "All done!"