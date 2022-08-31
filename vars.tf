# TODO: Add descriptions

variable "region" {
  default = "eu-west-1"
}

variable "environment" {
  description = "Deployment Environment"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24"]
}

variable "ami" {
  type    = string
  default = "ami-089950bc622d39ed8"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "azs" {
  type    = list(any)
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "vpc_security_group_ids" {
  type    = list(any)
  default = ["sg-04466ca0c06aa0258"]
}

variable "subnet_id" {
  type    = string
  default = "subnet-0a5b0961b33530bea"
}
variable "key_name" {
  type    = string
  default = "nedko"
}
