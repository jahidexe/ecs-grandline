variable "project_name" {
  description = "Project name to be used for tagging"
  type        = string
}

variable "common_tags" {
  description = "The common tags which will be applied to every resource"
  type        = map(string)
  default     = {}
}

variable "enable_dns_hostnames" {
  description = "To enable dns hostnames for VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "To enable dns support for VPC"
  type        = bool
  default     = true
}

variable "cidr_block" {
  description = "Specify the CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "To map public ip address on launch"
  type        = bool
  default     = true
}

variable "route_table_cidr_block" {
  description = "Route Table Destination CIDR Block"
  type        = string
  default     = "0.0.0.0/0"
}
