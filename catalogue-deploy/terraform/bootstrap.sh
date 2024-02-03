#!/bin/bash
component=$1
environment=$2
yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible botocore boto3

git clone https://github.com/CHAINVIPERX/robo-shop-lb.terraform.git /tmp/robo-shop-lb.terraform

cd /tmp/robo-shop-lb.terraform/ANSIBLE-ROLES-TF/

ansible-playbook -e component=$component -e env=$environment setup-tf.yaml

rm -rf /tmp/robo-shop-lb.terraform

#echo "${component} ${environment}"