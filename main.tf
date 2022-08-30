# resource "random_id" "random_id_prefix" {
#   byte_length = 2
# }

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

# terraform {
#   backend "s3" {
#     bucket = "state-20220830"
#     key    = "state"
#     # region = "eu-central-1"
#   }
# }

# data "terraform_remote_state" "state" {
#   backend = "s3"
#   config = {
#     bucket = "state-20220830"
#     key    = "state/terraform.tfstate"
#     region = "eu-central-1"
#   }
# }


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
  # Ensure that EC2 is EBS optimized
  # ebs_optimized = true

  # Launch configurations do not have encrypted EBS volumes
  root_block_device {
    encrypted = true
  }
  # Checkov - Ensure detailed monitoring for EC2 instances is enabled
  monitoring = true
  # Checkov ignore list:

  # Checkov - Ensure AWS EC2 instances aren't automatically made public with a public IP
  associate_public_ip_address = true

  availability_zone      = var.azs[0]
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  subnet_id              = var.subnet_id

  tags = {
    Name = "GeneratedByTerraform"
  }
}

# TODO - subscribe topic to to a subscription (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription)
resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
  # Ensure all data stored in the SNS topic is encrypted
  kms_master_key_id = "alias/aws/sns"
}

# RDS
# resource "aws_db_instance" "default" {
#   allocated_storage = 10
#   engine            = "mysql"
#   engine_version    = "5.7"
#   instance_class    = "db.t3.micro"
#   db_name           = "myDatabase"
#   username          = "nedko"

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "myDB" {

  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "myDatabase"
  username             = "nedko"
  password             = random_password.password.result
  parameter_group_name = "default.mysql5.7"

  skip_final_snapshot = true
  # Ensure RDS database has IAM authentication enabled
  iam_database_authentication_enabled = true
  # Ensure RDS instances have Multi-AZ enabled
  multi_az = true
  # Ensure respective logs of Amazon RDS are enabled
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  # Ensure enhanced monitoring for Amazon RDS instances is enabled
  # monitoring_interval = 5
  # Ensure AWS RDS DB cluster encryption is enabled
  storage_encrypted = true
  # Ensure DB instance gets all minor upgrades automatically
  auto_minor_version_upgrade = true
}
