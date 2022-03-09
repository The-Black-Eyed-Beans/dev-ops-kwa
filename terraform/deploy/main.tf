provider "aws" {
  profile = "kevin"
  shared_config_files = ["$HOME/.aws/config"]
  shared_credentials_files = ["$HOME/.aws/credentials"]
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
