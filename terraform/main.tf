terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.78.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-mf"
    key = "terraform.tfstate"
    region = var.region_name
  }
}

provider "aws" {
  region = "eu-west-1"
  profile = "Mark"
}
