# main.tf - Core Terraform configuration for AWS infrastructure

# Conditionally create a VPC if vpc_id is not provided
resource "aws_vpc" "this" {
  count                = var.vpc_id == "" ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.tags["Project"]}-vpc"
  })
}

# Use either existing VPC ID or newly created one
locals {
  effective_vpc_id = var.vpc_id != "" ? var.vpc_id : aws_vpc.this[0].id
}

# Conditionally create a subnet if subnet_id is not provided
resource "aws_subnet" "this" {
  count                   = var.subnet_id == "" ? 1 : 0
  vpc_id                  = local.effective_vpc_id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.tags["Project"]}-subnet"
  })
}

# Use either existing subnet ID or newly created one
locals {
  effective_subnet_id = var.subnet_id != "" ? var.subnet_id : aws_subnet.this[0].id
}

# Security group for SSH access
resource "aws_security_group" "ssh" {
  vpc_id = local.effective_vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.tags["Project"]}-sg"
  })
}

# Lookup latest Ubuntu AMI dynamically (no hardcoding)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 instance (Ubuntu)
resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.effective_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = merge(var.tags, {
    Name = "${var.tags["Project"]}-instance"
  })
}
