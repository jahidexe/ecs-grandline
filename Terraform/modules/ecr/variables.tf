variable "project_name" {
  description = "Project name to be used for tagging"
  type        = string
}


variable "common_tags" {
  description = "The common tags which will be applied to every resource"
  type        = map(string)
  default     = {}
}


variable "ecr_scan_on_push" {
  description = "Enable image scanning on push to ECR"
  type        = bool
  default     = true
}

