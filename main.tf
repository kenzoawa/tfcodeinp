# Creating the AWS VPC
resource "aws_vpc" "iplayer" {
    cidr_block              = "10.0.0.0/16"
    instance_tenancy        = "default"
    enable_dns_support      = "true"
    enable_dns_hostnames    = "true"
    enable_classiclink      = "false"
    tags {
        Name                = "iplayer-vpc"
    }
}


#create two public subnets in two availability zones
resource "aws_subnet" "iplayer-public-subnet" {
    vpc_id                  = "${aws_vpc.iplayer.id}"
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1a"

    tags {
        Name                = "iplayer-public-subnet"
    }
}

resource "aws_subnet" "iplayer-public-subnet-2" {
    vpc_id                  = "${aws_vpc.iplayer.id}"
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1b"

    tags {
        Name                = "iplayer-public-subnet-2"
    }
}

# create two private subnets in two availability zones
resource "aws_subnet" "iplayer-private-subnet" {
    vpc_id                  = "${aws_vpc.iplayer.id}"
    cidr_block              = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "us-east-1c"

    tags {
        Name = "iplayer-private-subnet"
    }
}
resource "aws_subnet" "iplayer-private-subnet-2" {
    vpc_id                  = "${aws_vpc.iplayer.id}"
    cidr_block              = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "us-east-1d"

    tags {
        Name = "iplayer-private-subnet-2"
    }
}
# attaching internet gateway to the VPC for internet access
resource "aws_internet_gateway" "iplayer-gw" {
    vpc_id                  = "${aws_vpc.iplayer.id}"
    depends_on              = ["aws_vpc.iplayer"]
    tags {
        Name                = "iplayer-internet-gw"
    }
}

# route table for the public subnets
resource "aws_route_table" "iplayer-public-route" {
    vpc_id                  = "${aws_vpc.iplayer.id}"
    route {
        cidr_block          = "0.0.0.0/0"
        gateway_id          = "${aws_internet_gateway.iplayer-gw.id}"
    }

    tags {
        Name                = "iplayer-public-route"
    }
}

# route associations for the public subnets
resource "aws_route_table_association" "iplayer-public-1-a" {
    subnet_id               = "${aws_subnet.iplayer-public-subnet.id}"
    route_table_id          = "${aws_route_table.iplayer-public-route.id}"
}
resource "aws_route_table_association" "iplayer-public-2-a" {
    subnet_id               = "${aws_subnet.iplayer-public-subnet-2.id}"
    route_table_id          = "${aws_route_table.iplayer-public-route.id}"
}