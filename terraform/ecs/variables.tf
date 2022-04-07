variable "vpc_id" {
	type = string
	description = "VPC ID"
}

variable "alb" {
	type = any
	description = "ALB"
}

variable "public" {
	type = any
	description = "public subnet 1"
}

variable "public2" {
	type = any
	description = "public subnet 2"
}

variable "sg_http" {
	type = any
	description = "sg http"
}

variable "sg_ssh" {
	type = any
	description = "sg ssh"
}
