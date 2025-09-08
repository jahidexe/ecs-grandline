variable "vpc_id" {
  description = "VPC ID where ALB and Target Group will be created"
  type        = string
}

variable "project_name" {
  description = "Project name to be used for tagging"
  type        = string
}

variable "common_tags" {
  description = "The common tags which will be applied to every resource"
  type        = map(string)
  default     = {}
}

variable "alb_ingress_ports" {
  description = "List of ports to allow inbound on ALB security group"
  type        = list(number)
  default     = [80]
}

variable "alb_allowed_cidrs" {
  description = "CIDR blocks allowed to access ECS tasks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "subnets" {
  description = "Subnets to attach the ALB to"
  type        = list(string)
}

variable "container_port" {
  description = "Port for Target Group and ALB listener"
  type        = number
  default     = 80
}