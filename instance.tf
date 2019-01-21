
#production web server with userdata bash script included at boot
resource "aws_instance" "web_server" {
ami                    = "ami-035be7bafff33b6b6" 
instance_type          = "t2.micro"
key_name               = "${var.KEY_PAIR}"
user_data              = "${file("userdata.sh")}"
availability_zone      = "us-east-1a"
vpc_security_group_ids = ["${aws_security_group.web_server_sg.id}"]
subnet_id              = "${aws_subnet.iplayer-public-subnet.id}"
tags {
   Name                = "production-web-servers"
   }
}

#production web server with userdata bash script included at boot
resource "aws_instance" "web_server2" {
ami                    = "ami-035be7bafff33b6b6" 
instance_type          = "t2.micro"
key_name               = "${var.KEY_PAIR}"
user_data              = "${file("userdata.sh")}"
availability_zone      = "us-east-1b"
vpc_security_group_ids = ["${aws_security_group.web_server_sg.id}"]
subnet_id              = "${aws_subnet.iplayer-public-subnet-2.id}"
tags {
   Name                = "production-web-servers"
   }
}

#attaching the EC2 instance to the load balancer in the assigned target groups 
resource "aws_alb_target_group_attachment" "web_server" {
target_group_arn       = "${aws_alb_target_group.lb-target-group-80.arn}"
port                   = 80
target_id              = "${aws_instance.web_server.id}"
}

resource "aws_alb_target_group_attachment" "web_server2" {
target_group_arn       = "${aws_alb_target_group.lb-target-group-80.arn}"
port                   = 80
target_id              = "${aws_instance.web_server2.id}"
}
