## VPC Module
module "vpc_1_subnet_public" {
  source               = "./modules/vpc_1_subnet_public"
  cidr_block           = var.vpc_cidr
  vpc-name             = var.vpc_name
  public_subnet_1_name = var.public_subnet_1_name
}

## EC2 Nginx Module
module "ec2_nginx" {
  source                = "./modules/ec2_nginx"
  ec2_instance_tag_name = var.ec2_tag_name
  ec2_instance_type     = var.instance_type
  ec2_vpc_id            = module.vpc_1_subnet_public.vpc_id
  ec2_subnet_id         = module.vpc_1_subnet_public.subnet_id
  ec2_ami               = var.ami
  ec2_instance_key_name = var.key_name
}

## Private subnet Module
module "private_subnet" {
  source             = "./modules/private_subnet"
  vpc-cidr           = var.vpc_cidr
  vpc-id             = module.vpc_1_subnet_public.vpc_id
  vpc-nat_gateway-id = module.vpc_1_subnet_public.nat_gateway_id
}

## Second public subnet
module "second_public_subnet" {
  source             = "./modules/second_subnet_public"
  vpc-cidr           = var.vpc_cidr
  vpc-id             = module.vpc_1_subnet_public.vpc_id
  vpc-nat_gateway-id = module.vpc_1_subnet_public.nat_gateway_id
}

## Elastic Load Balancer
module "elb" {
  source        = "./modules/elb"
  elb_subnet_id = [module.vpc_1_subnet_public.subnet_id]
  elb_vpc_id    = module.vpc_1_subnet_public.vpc_id
}

## Autoscaling group
module "asg" {
  source            = "./modules/asg"
  asg-ami           = var.ami
  asg-key-name      = var.key_name
  asg-subnet-id     = module.vpc_1_subnet_public.subnet_id
  vpc-id            = module.vpc_1_subnet_public.vpc_id
  asg-elb-name      = module.elb.name
  asg-instance-type = var.instance_type
  asg-max-size      = var.max_size
  asg-min-size      = var.min_size
}