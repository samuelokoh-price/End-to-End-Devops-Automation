# Region (already defaulted to us-east-1, override if needed)
aws_region = "us-east-1"

# EC2 instance type
instance_type = "t3.micro"

# Key pair name (must exist in AWS us-east-1)
key_name = "clw-kpair"

# If reusing an existing VPC/Subnet, supply IDs here
# Leave empty to let Terraform create new ones
vpc_id    = ""
subnet_id = ""

# CIDR blocks (used only if creating new VPC/Subnet)
vpc_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

# Tags (environment-specific)
tags = {
  Environment = "dev"
  Project     = "my-project"
  Owner       = "team-alpha"
}
