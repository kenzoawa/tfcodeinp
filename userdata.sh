#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker
sudo yum install docker
sudo usermod -a -G docker ec2-user
sudo service docker start