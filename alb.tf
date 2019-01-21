
#creating the application load balancer
resource "aws_lb" "iplayer-alb" {
  name               = "iplayer-alb-front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.LB_sg.id}"]
  subnets            = ["${aws_subnet.iplayer-public-subnet.id}"]
  subnets            = ["${aws_subnet.iplayer-public-subnet-2.id}"]

  enable_deletion_protection = false


  tags {
    Environment      = "production-lb"
  }
}

#creating the target group on port 80

resource "aws_alb_target_group" "lb-target-group-80" {
	name	             = "lb-target-group-80"
	vpc_id	           = "${aws_vpc.iplayer.id}"
	port               = "80"
	protocol           = "HTTP"

  tags {
        Name         = "alb-target-group-80"
       }
	health_check {
     path            = "/index.html"
     port            = "80"
     protocol        = "HTTP"
     healthy_threshold = 2
     unhealthy_threshold = 2
     interval        = 5
     timeout         = 4
     matcher         = "200-308"
        }
  depends_on         = ["aws_lb.iplayer-alb"]
}

#creating the listener for the ALB on port 80
resource "aws_alb_listener" "iplayer-alb-listener-80" {
	load_balancer_arn	  = "${aws_lb.iplayer-alb.arn}"
	port			          =	"80"
	protocol		        =	"HTTP"

	default_action {
		target_group_arn	=	"${aws_alb_target_group.lb-target-group-80.arn}"
		type		        	=	"forward"
	}
}
