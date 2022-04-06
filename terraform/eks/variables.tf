variable "public" {
	type = any
	description = "The public subnet of the VPC"
	default = "10.1.1.0/24"
}

variable "private" {
	type = any
	description = "The private subnet of the VPC"
	default = "10.1.2.0/24"
}

variable "public_subnet_id" {
	type = string
	description = "Public subnet ID"
}

variable "private_subnet_id" {
	type = string
	description = "Private subnet ID"
}