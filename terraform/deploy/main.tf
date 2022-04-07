provider "aws" {
	#access_key = var.aws_access_key
	#secret_key = var.aws_secret_key
	region  = var.region
}

#module "vpc" {
#	source = "../modules/vpc"
#	vpc_cidr = var.vpc_cidr
#	sg_http = module.security_groups.security_group_http
#	sg_ssh = module.security_groups.security_group_ssh
#}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"


  name = "kwa-aline-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_lb" "alb" {
    name = "kwa-alb"
    internal = false
    load_balancer_type = "application"
    subnets = module.vpc.public_subnets
    security_groups = [module.security_groups.security_group_http, module.security_groups.security_group_ssh, module.vpc.default_security_group_id]
}


module "security_groups" {
	source = "../modules/security-groups"
	vpc_id = module.vpc.vpc_id

}

module "ecs" {
	source = "../ecs"
	vpc_id = module.vpc.vpc_id
	alb = aws_lb.alb
	public = module.vpc.public_subnets[0]
	public2 = module.vpc.public_subnets[1]
	sg_http = module.security_groups.security_group_http
	sg_ssh = module.security_groups.security_group_ssh
}	

module "eks" {
	source = "../eks"
	public = module.vpc.public_subnets[0]
	private = module.vpc.private_subnets[1]

}

module "secret" {
	source = "../modules/secret"
	vpc_id = module.vpc.vpc_id
	alb = aws_lb.alb
	public1 = module.vpc.public_subnets[0]
	public2 = module.vpc.public_subnets[1]
	private1 = module.vpc.private_subnets[0]
	private2 = module.vpc.private_subnets[1]
	ecs_role = module.ecs.ecs_role
	task_role = module.ecs.task_role
	sg_http = module.security_groups.security_group_http
}