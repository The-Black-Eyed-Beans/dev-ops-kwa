variable "vpc_cidr" {
  type = string
  description = "CIDR block for VPC instance"
  default = "10.1.0.0/16"
}

variable "public_subnet_cidr_block" {
  type = string
  description = "CIDR block for public subnet"
  default = "10.1.1.0/24"
}

variable "private_subnet_cidr_block" {
  type = string
  description = "CIDR block for private subnet"
  default = "10.1.2.0/24"
}

variable "public_subnet_az" {
  type = string
  description = "Avalibility zone for public subnet"
  default = "us-east-1a"
}

variable "private_subnet_az" {
  type = string
  description = "Avalibility zone for private subnet"
  default = "us-east-1b"
}
