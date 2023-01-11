# data source
data "aws_ami" "nginx" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_launch_configuration" "launch_configuration" {
  image_id = data.aws_ami.nginx.id
  instance_type = var.asg-instance-type
  key_name = "newKey"
  security_groups = [aws_security_group.asg_security_group.id]
  user_data = <<-EOF
        #!/bin/bash
        sudo amazon-linux-extras install -y nginx1.12
        echo "<h1>Helloworld...</h1>" | sudo tee /usr/share/nginx/html/index.html
        sudo service nginx start
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "asg_security_group" {
  vpc_id = var.vpc-id

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
    Name = "asg security group"
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = "autoscaling_group"
  launch_configuration = aws_launch_configuration.launch_configuration.id
  vpc_zone_identifier = [var.asg-subnet-id]
  min_size = var.asg-min-size
  max_size = var.asg-max-size
  load_balancers = [var.asg-elb-name]
  health_check_type = "ELB"
}