terraform {
  required_version = "~> 1.3.5"
}

provider "aws" {
  region  = var.region
  profile = "terraform-user"
}