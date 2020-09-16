resource "aws_instance" "nat" {
	ami = "ami-0fa3a5c016146beec"
	instance_type = "t2.medium"
	key_name = "static-nat"
	security_groups = ["${aws_security_group.nat.id}"]
	subnet_id = "${aws_subnet.public.id}"
	associate_public_ip_address = true
	source_dest_check = false
	tags {
		Name = "nat"
	}
}

resource "aws_eip" "nat" {
	instance = "${aws_instance.nat.id}"
	vpc = true
}

resource "aws_security_group" "nat" {
	name = "nat"
	description = "Allow services from the private subnet through NAT"
	vpc_id = "${aws_vpc.mw_vpc.id}"

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 0
		to_port = 65535
		protocol = "tcp"
		security_groups = ["${aws_security_group.mw_sg_private.id}"]
	}

	ingress {
		from_port = 0
		to_port = 65535
		protocol = "udp"
		security_groups = ["${aws_security_group.mw_sg_private.id}"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	}