variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to use for EC2 instances"
  type        = string
  default     = "" # supply via tfvars or CLI
}

variable "vpc_id" {
  description = "ID of an existing VPC to deploy resources in"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (used if creating new)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_id" {
  description = "ID of an existing subnet to deploy resources in"
  type        = string
  default     = "" # leave empty if creating a new subnet
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet (used if creating new)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project = "my-project"
  }
}
