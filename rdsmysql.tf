#creting the RDS db subnet group
resource "aws_db_subnet_group" "mariadbsubnet" {
  name                   = "mariadbsubnet"
#assigning the right private subnets to the db subnet group
  subnet_ids             = ["${aws_subnet.iplayer-private-subnet.id}", "${aws_subnet.iplayer-private-subnet-2.id}"]

  tags  {
    Name                 = "My DB subnet group"
  }
}

#provisioning RDSMariaDB instance in the private subnet in our VPC and assiging the appropriate SG's
resource "aws_db_instance" "MariaDBdev" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mariadb"
  engine_version         = "10.3.8"
  instance_class         = "db.t2.micro"
  name                   = "iplayerdb"
#name of the database
  identifier             = "iplayerdb"
#master username
  username               = "su"
#password 
  password               = "dummypwdfordb"
  multi_az               = "false"
  parameter_group_name   = "default.mariadb10.3"
  skip_final_snapshot    = "true"
  vpc_security_group_ids = ["${aws_security_group.private_servers_sg.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.mariadbsubnet.id}"
#the az's in which mariadb will be deployed 
  availability_zone      = "${aws_subnet.iplayer-private-subnet.availability_zone}"

tags {
Name = "mariadb-instance"
}
}
