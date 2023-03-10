variable "region" {
  description = "value of region"
}

variable "vpc_cidr" {
  description = "value of vpc cidr"
}

variable "vpc_name" {
  description = "name of vpc"
}

variable "public_subnet_1_name" {
  description = "name of public subnet 1"
}

variable "ec2_tag_name" {
  description = "tag name of ec2"
}

variable "instance_type" {
  description = "instance type value"
}

variable "min_size" {}

variable "max_size" {}

variable "ami" {}

variable "key_name" {}