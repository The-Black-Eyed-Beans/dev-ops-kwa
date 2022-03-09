terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      // look into versionz
      version = "~> 4.2.0"
    }
  }
  
  backend "s3" {
    bucket  = "kwa-terraform-s3"
    key     = "terraform-infrastructure"
    region  = "us-east-1"
    profile = "default"
  }
}
