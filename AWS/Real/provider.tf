provider "aws" {
    region = "eu-west-1"
    access_key = "***"
    secret_key = "***"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}