#!/bin/bash

user="ec2-user"
key_path="./aws-private.pem"
#declare -a servers=("ec2-52-14-159-93.us-east-2.compute.amazonaws.com"
#                    "ec2-18-219-244-52.us-east-2.compute.amazonaws.com"
#                   )

declare -a servers=("ec2-52-14-159-93.us-east-2.compute.amazonaws.com")

for i in ${servers[@]}
do
    connect="$user@$i"
    echo $connect
    echo $key_path

    #ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $key_path $connect
    #ls
done

#ssh -i ./aws-private.pem
#
#sudo amazon-linux-extras install nginx1.12 -y
#sudo systemctl enable nginx
#sudo systemctl start nginx
#
#AWS_INSTANCEID="Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
#sudo sed -i.bak "s|Website Administrator|${AWS_INSTANCEID}|g" /usr/share/nginx/html/index.html
