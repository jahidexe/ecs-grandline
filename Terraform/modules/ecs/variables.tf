variable "region" {
  description = "AWS region"
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

variable "vpc_id" {
  description = "Specify the VPC ID"
  type        = string
}

variable "ecs_ingress_ports" {
  description = "List of ports to allow inbound on ECS tasks security group"
  type        = list(number)
  default     = [80]
}

variable "ecs_allowed_cidrs" {
  description = "CIDR blocks allowed to access ECS tasks"
  type        = list(string)
}

variable "ecs_task_cpu" {
  description = "The amount of CPU for ECS tasks"
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "The amount of memory (MB) for ECS tasks"
  type        = number
  default     = 512
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "ecs_task_network_mode" {
  description = "Mention the network mode for ECS task"
  type        = string
  default     = "awsvpc"
}

variable "container_image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "log_retention_days" {
  description = "Number of days to retain ECS logs"
  type        = number
  default     = 30
}


variable "launch_type" {
  description = "Specify the launch type for ECS task"
  type        = string
  default     = "FARGATE"
}

variable "ecs_task_subnets" {
  description = "The Subnets for ECS task"
  type        = list(string)
}

variable "alb_tg_arn" {
  description = "The ARN for the Target Group"
  type        = string
}

variable "health_check_grace_period_seconds" {
  description = "The value of health check grace period for ECS service"
  type        = number
  default     = 300
}


variable "image_uri" {
  type = string

}
