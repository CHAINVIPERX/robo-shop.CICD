#!/bin/bash
component=$1
environment=$2
app_version=$3
nexus_ip=$4
yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible botocore boto3

git clone https://github.com/CHAINVIPERX/robo-shop.CICD.git /tmp/robo-shop.CICD

cd /tmp/robo-shop.CICD/Infrastructure/ANSIBLE-ROLES-TF/


ansible-playbook -e component=$component -e env=$environment -e app_version=$app_version -e nexus_ip=$nexus_ip setup-tf.yaml
rm -rf /tmp/robo-shop-lb.terraform

#echo "${component} ${environment}"