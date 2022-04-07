variable "vpc_id" {
	type = any
	description = "The VPC ID"
}

variable "alb" {
	type = any
	description = "The Application Load Balancer"
}

variable "public1" {
	type = any
	description = "Public subnet 1 ID"
}

variable "public2" {
	type = any
	description = "Public subnet 2 ID"
}

variable "private1" {
	type = any
	description = "Private subnet 1 ID"
}

variable "private2" {
	type = any
	description = "Private subnet 2 ID"
}

variable "ecs_role" {
	type = any
	description = "Execution Role"
}

variable "task_role" {
	type = any
	description = "Task Role"
}

variable "sg_http" {
	type = any
	description = "Security group for HTTP"
}