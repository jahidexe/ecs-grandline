# -------------------
# VPC Outputs
# -------------------

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# ----------------------
# Public Subnet Outputs
# ----------------------

output "public_subnet_ids" {
  description = "List of IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "public_subnet_azs" {
  description = "List of AZs where public subnets are created"
  value       = aws_subnet.public[*].availability_zone
}

# ----------------------
# Private Subnet Outputs
# ----------------------

output "private_subnet_ids" {
  description = "List of IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  value       = aws_subnet.private[*].cidr_block
}

# --------------------------
# Internet Gateway Outputs
# --------------------------

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# -------------------
# Route Table Outputs
# -------------------

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}
