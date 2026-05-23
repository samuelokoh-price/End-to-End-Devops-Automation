# EC2 Instance outputs
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

# Networking outputs
output "subnet_id" {
  description = "The ID of the subnet used by the EC2 instance"
  value       = local.effective_subnet_id
}

output "vpc_id" {
  description = "The ID of the VPC used by the EC2 instance"
  value       = local.effective_vpc_id
}

# Security group outputs
output "security_group_id" {
  description = "The ID of the security group attached to the EC2 instance"
  value       = aws_security_group.ssh.id
}
