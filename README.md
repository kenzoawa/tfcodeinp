# tfcodeinp

The terraform code creates :

VPC 
 - private subnets in multiple AZ's
 - public subnets in multiple AZ's
 - security groups for databases and web servers (ec2) and appropriate rules
 - NACL for public and private subnets and the rules with security best practices 
 - route tables for the public subnet
 - internet gateway
 
NAT is not provisioned due to RDS no EC2 instances in the private subnet.

ALB/ELB
 - multi-az for the public subnets
 - target group for port 80 / 443 is skipped due to terraform apply error because of non existent certificate
 - listeners only on port 80 and 443
 
RDS
 - MariaDB RDS instance
 - db subnet group with the private subnets of the VPC attached
 - no az replication due to free-tier
 - db.t2.micro
 
EC2
 - two linux ami t2.micro from marketplace
 - userdata bash script for docker automated installtion on boot
 - attached the appropriate SG
 - automated provisioning into ALB

Not included : terraform state file, vars.tf, provider.tf

Additionally an launch configuration and autoscaling can be added for increased high availability and fault tolerant infrastructure.
