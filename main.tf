module "vpc_1_subnet_public" {
  source               = "./modules/vpc_1_subnet_public"
  cidr_block           = var.vpc_cidr
  vpc-name             = var.vpc_name
  public_subnet_1_name = var.public_subnet_1_name
}