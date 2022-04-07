variable "public" {
	type = any
	description = "public subnet 1"
}

variable "private" {
	type = any
	description = "private subnet 1"
}

variable "cluster_name" {
	type = string
	description = "Cluster name for EKS"
	default = "kwa-cluster"
}

