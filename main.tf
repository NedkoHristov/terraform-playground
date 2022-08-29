# resource "random_id" "random_id_prefix" {
#   byte_length = 2
# }

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "networking" {
  source               = "./modules/networking"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones

}

resource "aws_instance" "tf_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  # Checkov - Ensure Instance Metadata Service version 1 is not enabled
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  # Checkov - Ensure detailed monitoring for EC2 instances is enabled
  monitoring = true
  # TODO - attach EBS volume to satisfy checkov's checks
  # Checkov - Ensure that EC2 is EBS optimized
  #  ebs_optimized          = true
  # Checkov - Ensure AWS EC2 instances aren't automatically made public with a public IP

  # Checkov - Ensure Elastic Load Balancers use SSL certificates provided by AWS Certificate Manager

  associate_public_ip_address = true
  availability_zone           = var.azs[0]
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id

  tags = {
    Name = "GeneratedByTerraform"
  }
}