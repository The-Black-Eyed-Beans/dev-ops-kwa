provider "aws" {
	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
	region  = var.region
}

module "vpc" {
	source = "../modules/vpc"
	vpc_cidr = var.vpc_cidr

}

module "security_groups" {
	source = "../modules/security-groups"
	vpc_id = module.vpc.vpc_id
}

module "ecs" {
	source = "../ecs"
}

module "eks" {
	source = "../eks"
	private_subnet_id = module.vpc.private_subnet_id
	public_subnet_id = module.vpc.public_subnet_id

}
