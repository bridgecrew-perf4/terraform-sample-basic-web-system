##########################
# Confidential information. Get from variables.tfvars.
##########################
variable "assume_role_arn" {
  description = "Role to run terraform."
}
variable "vpc_id" {
  description = "Set the ID of the development VPC."
}
variable "igw_id" {
  description = "Set the ID of the development IGW."
}

##########################
# Common
##########################
variable "system_name" {
  default = "basic-web-system"
}

variable "env" {
  default = {
    prd = "prd"
    stg = "stg"
    dev = "dev"
  }
}

variable "az_a" {
  default = "ap-northeast-1a"
}

variable "az_c" {
  default = "ap-northeast-1c"
}

##########################
# VPC
##########################
variable "subnet_cidr_block_public_a" {
  default = "100.0.10.0/24"
}
variable "subnet_cidr_block_public_c" {
  default = "100.0.20.0/24"
}
variable "subnet_cidr_block_private_a" {
  default = "100.0.30.0/24"
}
variable "subnet_cidr_block_private_c" {
  default = "100.0.40.0/24"
}
variable "subnet_cidr_block_secure_a" {
  default = "100.0.50.0/24"
}
variable "subnet_cidr_block_secure_c" {
  default = "100.0.60.0/24"
}

##########################
# EC2
##########################
variable "ami_ap" {
  default = "ami-0c6f9336767cd9243"
}
variable "instance_type_ap" {
  default = "t2.micro"
}
variable "key_pair_name" {
  default = "20210203"
}

##########################
# ELB
##########################
variable "logging_bucket" {
  default = "tfstate.mini-schna.com"
}