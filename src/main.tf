terraform {
  required_version = "0.14.5"
  backend "s3" {
    bucket  = "tfstate.common"
    region  = "ap-northeast-1"
    key     = "terraform-sample-basic-web-system/dev.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
  assume_role {
    role_arn = var.assume_role_arn
  }
}

# module "this" {
#   source = "./module"

#   ########################
#   # common
#   ########################
#   system_name = var.system_name
#   env         = var.env["stg"]
#   az_a        = var.az_a
#   az_c        = var.az_c

#   ########################
#   # vpc
#   ########################
#   vpc_id                      = var.vpc_id
#   igw_id                      = var.igw_id
#   subnet_cidr_block_public_a  = var.subnet_cidr_block_public_a
#   subnet_cidr_block_public_c  = var.subnet_cidr_block_public_c
#   subnet_cidr_block_private_a = var.subnet_cidr_block_private_a
#   subnet_cidr_block_private_c = var.subnet_cidr_block_private_c
#   subnet_cidr_block_secure_a  = var.subnet_cidr_block_secure_a
#   subnet_cidr_block_secure_c  = var.subnet_cidr_block_secure_c

#   ########################
#   # ec2
#   ########################
#   ami_ap = var.ami_ap
#   instance_type_ap = var.instance_type_ap
# }
