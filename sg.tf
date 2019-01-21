#web server security group with inbound and outbound rules
resource "aws_security_group" "web_server_sg" {
  vpc_id            = "${aws_vpc.iplayer.id}"
  name              = "web_server_sg"
  description       = "security group that allows web traffic"

  egress {
      from_port     = 0
      to_port       = 0
      protocol      = "-1"
      cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
      from_port     = 80
      to_port       = 80
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  } 

  ingress {
      from_port     = 443
      to_port       = 443
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  } 
  tags {
    Name = "web_servers_sg"
  }
}

#database server security group with inbound and outbound rules
resource "aws_security_group" "private_servers_sg" {
  vpc_id            = "${aws_vpc.iplayer.id}"
  name              = "private_servers_sg"
  description       = "security group that manages private servers"

   egress {
      from_port     = 80
      to_port       = 80
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  }
     egress {
      from_port     = 443
      to_port       = 443
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  }
    egress {
      from_port     = 0
      to_port       = 0
      protocol      = "-1"
      cidr_blocks   = ["10.0.0.0/16"]
  }
  ingress {
      from_port     = 3306
      to_port       = 3306
      protocol      = "tcp"
      cidr_blocks   = ["10.0.0.0/16"]
  } 

  tags {
    Name = "db_servers_sg"
  }
}

#load balancer security group
resource "aws_security_group" "LB_sg" {
  vpc_id            = "${aws_vpc.iplayer.id}"
  name              = "lb_sg"
  description       = "security group that allows web traffic"

  egress {
      from_port     = 0
      to_port       = 0
      protocol      = "-1"
      cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
      from_port     = 80
      to_port       = 80
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  } 
  ingress {
      from_port     = 443
      to_port       = 443
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  } 
tags {
    Name = "lb_sg"
  }
}