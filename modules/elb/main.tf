resource "aws_elb" "elb" {
  name            = "my-elb"
  security_groups = [aws_security_group.elb_sg.id]
  subnets         = var.elb_subnet_id

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  tags = {
    Name = "Elastic Load Balancer"
  }
}

resource "aws_security_group" "elb_sg" {
  name   = "Elb HTTP Access"
  vpc_id = var.elb_vpc_id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb security group"
  }
}