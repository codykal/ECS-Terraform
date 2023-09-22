terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket         = "ecsproject-tfstatebucket"
    key            = "ECSProject/terraform.tfstate"
    region         = "us-west-2"
    profile        = "administrator"
    encrypt        = true
    dynamodb_table = "my-lock-table"

  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}



