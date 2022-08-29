terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "terraform_demo" {
  ami                    = "ami-089950bc622d39ed8"
  instance_type          = "t2.micro"
  availability_zone      = "eu-west-1a"
  vpc_security_group_ids = ["sg-04466ca0c06aa0258"]
  subnet_id              = "subnet-0a5b0961b33530bea"
  key_name               = "nedko"
  tags = {
    Name = "myFirstTerraformEC2"
  }
}