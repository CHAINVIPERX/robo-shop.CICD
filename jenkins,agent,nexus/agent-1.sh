#!/bin/bash
sudo yum install fontconfig java-17-openjdk -y
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
sudo dnf module disable nodejs -y
sudo dnf module enable nodejs:18 -y
sudo dnf install nodejs -y