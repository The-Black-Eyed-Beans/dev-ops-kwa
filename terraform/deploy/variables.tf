variable "region" {
  type = string
  description = "Region to deploy services"
  default = "us-east-1"
}

variable "vpc_cidr" {
	type = string
	description = "CIDR for the VPC"
	default = "10.1.0.0/16"
}

variable "vpc_name" {
	type = string
	description = "Name for VPC"
	default = "kwa-infrastructure"
}

variable "public" {
	type = string
	description = "Public subnet CIDR"
	default = "10.1.1.0/24"
}

variable "private" {
	type = string
	description = "Private subnet CIDR"
	default = "10.1.2.0/24"
}

variable "az" {
	type = string
	description = "Availability zone"
	default = "us-east-1a"
}

variable "aws_access_key" {
    type = string
    description = "aws access key"
    sensitive = true
}

variable "aws_secret_key" {
    type = string
    description = "aws secret key"
    sensitive = true
}