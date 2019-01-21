#public network access list which is associated with public subnets for inbound and outboud traffic
resource "aws_network_acl" "public-nacl" {
  vpc_id            = "${aws_vpc.iplayer.id}"
  subnet_ids        = [ "${aws_subnet.iplayer-public-subnet.id}" ]
  subnet_ids        = [ "${aws_subnet.iplayer-public-subnet-2.id}" ]
  
  egress {
    protocol        = "all"
    rule_no         = 100
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 0
    to_port         = 0
  }

  ingress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 1024
    to_port         = 65535
  }
    ingress {
    protocol        = "tcp"
    rule_no         = 200
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 80
    to_port         = 80
  }
   ingress {
    protocol        = "tcp"
    rule_no         = 300
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 443
    to_port         = 443
  }

  tags {
    Name            = "public-nacl"
  }
}

#private network access list associated with the private subnets for inbound and outbound traffic
resource "aws_network_acl" "private-nacl" {
  vpc_id            = "${aws_vpc.iplayer.id}"
  subnet_ids        = [ "${aws_subnet.iplayer-private-subnet.id}" ]
  subnet_ids        = [ "${aws_subnet.iplayer-private-subnet-2.id}" ]
    egress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 80
    to_port         = 80
  }
    egress {
    protocol        = "tcp"
    rule_no         = 200
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 443
    to_port         = 443
  }
    egress {
    protocol        = "tcp"
    rule_no         = 300
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 32768
    to_port         = 65535
  }

  ingress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = "10.0.0.0/16"
    from_port       = 1024
    to_port         = 65535
  }
    ingress {
    protocol        = "tcp"
    rule_no         = 200
    action          = "allow"
    cidr_block      = "10.0.0.0/16"
    from_port       = 3306
    to_port         = 3306
  }

  tags {
    Name            = "private-nacl"
  }
}
